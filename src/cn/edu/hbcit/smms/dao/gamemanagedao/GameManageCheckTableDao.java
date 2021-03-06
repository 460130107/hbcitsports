/*
* Copyright(C) 2012, XXXXXXXX.
*
* 模块名称：     AAAAAAAAAAA
* 子模块名称：   BBBBBBBBBBB
*
* 备注：
*
* 修改历史：
* 时间			版本号	姓名		修改内容
* 2004/12/12		0.1		张 三		新建
* 2005/02/05		0.1		李 四		Bug修正
*/
package cn.edu.hbcit.smms.dao.gamemanagedao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;

import cn.edu.hbcit.smms.dao.databasedao.DBConn;
import cn.edu.hbcit.smms.dao.logindao.LoginDAO;
import cn.edu.hbcit.smms.pojo.GameManageCheckTablePojo;

/**
 *赛中管理---检录表 数据库操作类
 *
 *连接数据库
 *
 *详细解释。
 * @author 杨春华
 * @version 1.00  2011/12/07 新規作成<br>
 */

public class GameManageCheckTableDao {
	private static Connection conn;
	private static ResultSet rs;
	protected final Logger log = Logger.getLogger(GameManageCheckTableDao.class.getName());
	private LoginDAO loginDAO = new LoginDAO();
	/**
	 * 获取运动会组别
	 * @author 杨春华
     * @return grouplist
	 */
	public ArrayList getGroupList() {
		DBConn db = new DBConn();
		ArrayList grouplist=new ArrayList();
        try {
            Connection conn = db.getConn();
           
            if(conn != null){
                Statement statement = conn.createStatement(); 
                ResultSet rs = statement.executeQuery("select id, groupname from t_group where id IN (select groupid from t_group2sports where sportsid="+loginDAO.selectCurrentSportsId()+" )"); 
                int c = rs.getMetaData().getColumnCount();
                while(rs.next()){
                	GameManageCheckTablePojo ct=new GameManageCheckTablePojo(); 
                   ct.setGroupId(rs.getInt(1));
                   ct.setGroupName(rs.getString(2));
                   grouplist.add(ct);
                    for(int i=1;i<=c;i++){
                          log.debug(rs.getObject(i));
                    }
                }
                rs.close();
                statement.close();
            }
            db.freeConnection(conn);
        } catch (SQLException e) { 
        	log.debug(e.getMessage());
            e.printStackTrace();       
        } 
        return grouplist;
      
    }
	
	/**
	 * 
	* 获取运动会的项目名称	
	* @param groupid
	* @return itemList
	 */
	public ArrayList getItemList(int groupid){
		//System.out.println("getItemList-->groupid="+groupid);
		int sportsid = loginDAO.selectCurrentSportsId();
		DBConn db = new DBConn();
		ArrayList itemlist=new ArrayList();
        try {
            Connection conn = db.getConn();
            if(conn != null){
                Statement statement = conn.createStatement(); 
                ResultSet rs = statement.executeQuery(
                		"select finalitemtype, finalitemname from t_finalitem " +
                		"where gp2itid in (select id from t_group2item " +
                		"where gp2spid =(select id from t_group2sports " +
                		"where groupid='"+groupid+"' and sportsid='"+sportsid+"'))"); 
                int c = rs.getMetaData().getColumnCount();
                while(rs.next()){
                	GameManageCheckTablePojo ct=new GameManageCheckTablePojo(); 
                    ct.setItemType(rs.getString(1));
                    ct.setItemName(rs.getString(2));
                   itemlist.add(ct);
                    for(int i=1;i<=c;i++){
                          log.debug(rs.getObject(i));
                    }
                }
                rs.close();
                statement.close();
            }
            db.freeConnection(conn);
        } catch (SQLException e) {  
        	log.debug(e.getMessage());
            e.printStackTrace();       
        } 
        return itemlist;	
		
	}
	
	
	/**
	 * 
	* 判断预赛的成绩是否为空	
	* 方法补充说明
	* @return boolean 
	 */
	public boolean isScoreNull( String finalitemname ) {
		DBConn db = new DBConn();
		boolean flag = false;
        try {
            Connection conn = db.getConn();
            if(conn != null){
                Statement statement = conn.createStatement();
               
                ResultSet rs = statement.executeQuery( "select score from t_match where finalitemid in (select id from t_finalitem where finalitemname='" + finalitemname+"')");  
               
                if(rs.next()){
                   
                	flag=true;
                  
                }
                rs.close();
                statement.close();
            }
            db.freeConnection(conn);
        } catch (SQLException e) {
        	log.debug(e.getMessage());
            e.printStackTrace();       
        } 
        return flag;
      
    }
	/**
	 * 
	* getFinalMatchList
	* 方法补充说明	获得指定项目的一个小组的运动员信息
	* @param 
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	
	public JSONArray getOneItemPlayerMessageByTeam( String itemname ,String finalitemtype ,int teamnum ){
			//System.out.println("finalitemtype="+finalitemtype);
			DBConn db = new DBConn();
			JSONArray alllist = new JSONArray();
			Connection conn = null;
			String sql = null; 
			GameManageCheckTableDao gmctd = new GameManageCheckTableDao();
			String matchtype = gmctd.getMatchType(itemname);		//获取比赛类型       1：径赛，2：田赛，3：接力
			if( finalitemtype.equals("1") || finalitemtype.equals("3")  ){		//预赛、预决赛
				if( matchtype.equals("1") || matchtype.equals("2")){				//竞赛、田赛
					//System.out.println("matchtype="+matchtype);
					sql = "SELECT t_match.teamnum,t_player.playernum,t_player.playername,t_match.runway FROM " +
					"t_match JOIN t_player ON t_player.id=t_match.playerid WHERE " +
					"t_match.finalitemid in (SELECT id FROM t_finalitem WHERE finalitemname in " +
					"(SELECT finalitemname FROM t_finalitem WHERE finalitemtype = '"+finalitemtype+"'  AND  gp2itid in (" +
							"SELECT gp2itid FROM t_finalitem WHERE finalitemname = '"+itemname+"')) AND sportsid = '"+loginDAO.selectCurrentSportsId()+"') and teamnum = '"+teamnum+"' order by runway";
				}else{			//接力
					sql = "SELECT t_match.playerid,t_department.departshortname,t_match.teamnum,t_match.runway " +
					"FROM t_match JOIN t_finalitem ON t_match.finalitemid = t_finalitem.id JOIN t_department ON t_match.playerid = t_department.id " +
					"WHERE t_finalitem.finalitemname = '"+itemname+"' and t_finalitem.sportsid="+loginDAO.selectCurrentSportsId()+" and finalitemtype = '"+finalitemtype+"'";
				} 
			}else{//决赛
				
				//System.out.println("finalitemtype="+finalitemtype);
					if( matchtype.equals("1") || matchtype.equals("2") ){		//竞赛、田赛
						sql = "SELECT t_match.teamnum,t_player.playernum,t_player.playername,t_match.runway FROM " +
								"t_match JOIN t_player ON t_player.id=t_match.playerid WHERE " +
								"t_match.finalitemid IN(   SELECT id  FROM t_finalitem WHERE finalitemtype = '"+finalitemtype+"'  AND  gp2itid IN ( " +
								"SELECT gp2itid FROM t_finalitem WHERE finalitemname = '"+itemname+"' AND sportsid = '"+loginDAO.selectCurrentSportsId()+"' )) AND teamnum = '"+teamnum+"' ORDER BY runway  ";
					}else{		//接力
						sql = "SELECT t_match.playerid,t_department.departshortname,t_match.teamnum,t_match.runway " +
								"FROM t_match JOIN t_finalitem ON t_match.finalitemid = t_finalitem.id JOIN t_department ON t_match.playerid = t_department.id " +
								"WHERE t_finalitem.finalitemname = '"+itemname+"' and t_finalitem.sportsid="+loginDAO.selectCurrentSportsId()+" and finalitemtype = '"+finalitemtype+"'";
					}
			}
			
	        try {
	        		conn = db.getConn(); 
	                Statement statement = conn.createStatement();
	              //juesai
	                if(finalitemtype.equals("2")){
	                if( matchtype.equals("1") || matchtype.equals("2") ){//竟赛和田赛
	                	 ResultSet rs = statement.executeQuery(sql);	
	                	 while( rs.next() ){
	                		 JSONArray list = new JSONArray();
	                		 //list.add(Integer.toString(rs.getInt(1)));
	                		 list.add(rs.getString(2));
	                		 list.add(rs.getString(3));
	                		 list.add(Integer.toString(rs.getInt(4)));
	                		 alllist.add(list);
	  	                }
	  	                rs.close();
	                }
	                
	                //接力
	                if( matchtype.equals("3") ){
	                	 ResultSet rs = statement.executeQuery(sql);
	                	 while(rs.next()){
	                		 JSONArray list = new JSONArray();
	                		 //list.add(Integer.toString(rs.getInt(1)));
	                		 list.add(rs.getString(1));
	                		 list.add(rs.getString(2));
	                		 list.add(rs.getString(4));
	                		 alllist.add(list); 
	                	 }
	                	 rs.close();
	                }
	                }
	                else{
	                	if( matchtype.equals("1") || matchtype.equals("2")){//竟赛和田赛
		                	 ResultSet rs = statement.executeQuery(sql);	
		                	 while( rs.next() ){  
		                		 JSONArray list = new JSONArray();
		                		 //list.add(Integer.toString(rs.getInt(1)));
		                		 list.add(rs.getString(2));
		                		 list.add(rs.getString(3));
		                		 list.add(Integer.toString(rs.getInt(4)));
		                		 alllist.add(list);
		  	                }
		  	                rs.close();
		                }
		                
		                //接力
		                if(  matchtype.equals("3") ){
		                	 ResultSet rs = statement.executeQuery(sql);
		                	 while(rs.next()){
		                		 JSONArray list = new JSONArray();
		                		 //list.add(Integer.toString(rs.getInt(1)));
		                		 list.add(rs.getString(1));
		                		 list.add(rs.getString(2));
		                		 list.add(rs.getString(4));
		                		 alllist.add(list); 
		                	 }
		                	 rs.close();
		                }
	                	
	                }
	                statement.close();
	                db.freeConnection(conn);
	        } catch (SQLException e) {  
	        	log.debug(e.getMessage());
	            e.printStackTrace();     
	        }
		return alllist;
	}
	
	/**
	 * 
	* 方法说明	
	* 方法补充说明		获取某个项目的全部小组的运动员的信息
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public JSONArray getItemPlayerMessageAllTeam( String finalitemname ,String itemtype  ){
		//1预赛；2决赛；3预决赛
		JSONArray alllist = new JSONArray();
		int flag = 0;
		if( "2".equals(itemtype)){
			GameManageCheckTableDao gmctd = new GameManageCheckTableDao();
			int promotionnum = 0;
			promotionnum = gmctd.getPromotionnum(finalitemname);//项目规定的晋级数
			//System.out.println("promotionnum="+promotionnum);
			//System.out.println("isFinalScoreEmpty(finalitemname)="+isFinalScoreEmpty(finalitemname));
			if( this.isFinalScoreEmpty(finalitemname)){
				deleteFinalScore(finalitemname);
				//updateFinalMatch(finalitemname ,promotionnum);//设置决赛赛道
				finalScore( promotionnum, finalitemname);
			}else{
				//updateFinalMatch(finalitemname ,promotionnum);//设置决赛赛道
				finalScore( promotionnum, finalitemname);
			}
			
		}
		flag = getItemTeamnumber(finalitemname);//获得项目的小组数
		//System.out.println("flag="+flag);
		for( int i = 0 ; i < flag ; i++){
			JSONArray list = new JSONArray();
			list = getOneItemPlayerMessageByTeam(finalitemname, itemtype,i+1);
			alllist.add(list);
		}
		return alllist;
		
	}
	/**
	 * 
	* 方法说明	
	* 方法补充说明		获取指定项目的小组数
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public int getItemTeamnumber( String finalitemname ){
		//System.out.println("finalitemname="+finalitemname);
		String sql = "SELECT COUNT(DISTINCT(teamnum)) FROM t_match WHERE finalitemid " +
		"IN ( SELECT id FROM t_finalitem WHERE finalitemname = ? )";
		DBConn db = new DBConn();
		conn = db.getConn();
		int flag = 0;
		PreparedStatement  pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,finalitemname);
			rs = pstmt.executeQuery();
			while( rs.next() ){
				flag = rs.getInt(1);
			}
			 db.freeConnection(rs,pstmt,conn);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 
	* 方法说明	
	* 方法补充说明	获取指定项目的项目类型      例如：1：径赛，2：田赛，3：接力
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public String getMatchType( String finalitemname ){
		String sql = "SELECT itemtype from t_item where id in (" +
		"SELECT itemid from t_group2item where id in (" +
		"SELECT gp2itid from t_finalitem where finalitemname = '"+finalitemname+"'))";
		DBConn db = new DBConn();
		conn = db.getConn();
		String str = "";
		try {
			Statement statement = conn.createStatement();
			rs = statement.executeQuery(sql);
			while( rs.next() ){
				str = rs.getString("itemtype");
				
			}
			rs.close();
			statement.close();
			 db.freeConnection(conn);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return str;
	}
	
	
	/**
	 * 
	* 方法说明	
	* 方法补充说明		设置决赛赛道
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public int updateFinalMatch( String finalitemname ,int promotionnum,int a ,int b,int c){
		
		PreparedStatement  pstmt = null;	ResultSet rs = null;
		PreparedStatement pstmt1 = null;	ResultSet rs1 = null; 
		String sql = "INSERT INTO t_match (teamnum,runway,playerid,finalitemid) VALUES (?,?,?,?)";
		
		GameManageCheckTableDao gmctd = new GameManageCheckTableDao();
		String matchType = null;
		matchType = gmctd.getMatchType(finalitemname);//1：径赛，2：田赛，3：接力
		
		int finalitemid = getFinalitemid(finalitemname);	//finalitemid
		int num = 0;
		int[] runway = gmctd.getFinalRunWay(c);//赛道分配
		//System.out.println("runway="+runway.length);
		DBConn db = new DBConn();
		conn = db.getConn();
		if( "1".equals(matchType) || "3".equals(matchType) ){
			String sql1 = "SELECT playerid FROM t_match WHERE finalitemid IN ( SELECT id FROM t_finalitem WHERE gp2itid IN ( " +
					"SELECT gp2itid FROM t_finalitem WHERE finalitemname = ? AND sportsid = ? ) " +
					"AND finalitemtype = '1' AND (t_match.foul=0 OR t_match.foul IS NULL)) ORDER BY score+0  LIMIT ?,?";
			try {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, finalitemname);
				pstmt.setInt(2, loginDAO.selectCurrentSportsId());
				pstmt.setInt(3, promotionnum);
				pstmt.setInt(4, b);
				rs = pstmt.executeQuery();
				pstmt1 = conn.prepareStatement(sql);
				//System.out.println("qwerqweqweqweqweqweq");
					for( int i = 0 ; i < runway.length ; i++ ){
						//System.out.println("runway="+runway[i]);
						rs.next();
						pstmt1.setInt(1, a);
						pstmt1.setInt(2, runway[i]);
						pstmt1.setInt(3, rs.getInt(1));
						pstmt1.setInt(4, finalitemid);
						num += pstmt1.executeUpdate();
						//System.out.println("num="+num+",runway[i]="+runway[i]);
					}
					rs.close();
					pstmt1.close();
				
				
				db.freeConnection(conn);
			} catch (Exception e) {
				log.debug(e.getMessage());
				e.printStackTrace();
			}
			
		}if("2".equals(matchType)){
			String sql1 = "SELECT playerid FROM t_match WHERE finalitemid IN ( SELECT id FROM t_finalitem WHERE gp2itid IN ( " +
					"SELECT gp2itid FROM t_finalitem WHERE finalitemname = ? AND sportsid = ? ) " +
					"AND finalitemtype = '1' AND (t_match.foul=0 OR t_match.foul IS NULL)) ORDER BY score+0 DESC LIMIT ?,?";
			
			try {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, finalitemname);
				pstmt.setInt(2, loginDAO.selectCurrentSportsId());
				pstmt.setInt(3, promotionnum);
				pstmt.setInt(4, b);
				rs = pstmt.executeQuery();
				
				pstmt1 = conn.prepareStatement(sql);
				
					for( int i = 0 ; i < runway.length ; i++ ){
						rs.next();
						pstmt1.setInt(1, a);
						pstmt1.setInt(2, runway[i]);
						pstmt1.setInt(3, rs.getInt(1));
						pstmt1.setInt(4, finalitemid);
						num += pstmt1.executeUpdate();
						//System.out.println("num="+num+",runway[i]="+runway[i]);
					}
				rs.close();
				pstmt1.close();
				pstmt.close();
				db.freeConnection(conn);
			} catch (Exception e) {
				log.debug(e.getMessage());
				e.printStackTrace();
			}
			
		}
		return num;
	}
	
	/**
	 * 
	* 方法说明	
	* 方法补充说明	生成决赛赛道
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public int[] getFinalRunWay( int Promotionnum ){
		//System.out.println("");
		int[] runway = new int[Promotionnum];
		  int a = 1;
		  runway[0] = 5;
		  int k = (-1);
		 
		  for (int i = 1; i < Promotionnum; i++){
			  if(i%2 == 0){
				  k = 1;
			  }
			  if(i%2==1){
				  k = (-1);
			  }
			  runway[i] = 5 + a*k; 
			  if(i%2 == 0){
				  a++;
			  }
		  }
		return runway;
		
	}
	/**
	 * 
	* 方法说明	
	* 方法补充说明	获取指定项目的晋级标注
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public int getPromotionnum( String finalitemname ){
		//System.out.println("getPromotionnum-->finalitemname="+finalitemname);
		String sql = "SELECT promotionnum FROM t_finalitem " +
				"WHERE gp2itid IN ( SELECT gp2itid FROM t_finalitem WHERE finalitemname = ? ) AND (finalitemtype = '3' OR finalitemtype = '1')";
		DBConn db = new DBConn();
		conn = db.getConn();
		PreparedStatement  pstmt = null;
		ResultSet rs = null;
		int flag = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finalitemname);
			rs = pstmt.executeQuery();
			//System.out.println("rs="+rs.next());
			if( rs.next() ){
				//System.out.println("rs=");
				flag = rs.getInt(1);
				//System.out.println("flag="+flag);
			}
			rs.close();
			pstmt.close();
			 db.freeConnection(conn);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		//System.out.println("rs="+flag);
		return flag; 	
		
	}
	 /**获取当前运动会的名字
	  * 
	 * 方法说明	
	 * 方法补充说明
	 * @param 参数名 参数类型 参数意义注释
	 * @return 返回值的类型 意义注释
	 * @exception 例外的类型 意义注释
	  */
	public String getSportsName(){
		return loginDAO.selectCurrentSportsName();
	}
	/**
	 * 获取项目的finalitemid
	* 方法说明	
	* 方法补充说明
	* @param 参数名 参数类型 参数意义注释
	* @return 返回值的类型 意义注释
	* @exception 例外的类型 意义注释
	 */
	public int getFinalitemid( String finalitemname){
		String sql = "SELECT id FROM t_finalitem WHERE finalitemname = ? AND sportsid = ?";
		int finalitemid = 0;
		DBConn db = new DBConn();
		conn = db.getConn();
		PreparedStatement  pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finalitemname);
			pstmt.setInt(2, loginDAO.selectCurrentSportsId());
			rs = pstmt.executeQuery();
			if( rs.next()){
				finalitemid = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			db.freeConnection(conn);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return finalitemid ;
	}

	//获取当前比赛时间
	public boolean getdate( String finalitemname,String finalitemtype){
		String sql = "SELECT score FROM t_match WHERE finalitemid IN (SELECT " +
				"id FROM t_finalitem WHERE gp2itid=(SELECT gp2itid FROM t_finalitem WHERE" +
				" finalitemname = ? AND sportsid = ? ) AND finalitemtype =1)";
		boolean flag = false;//可以点
		String gameTime = null;
		DBConn db = new DBConn();
		conn = db.getConn();
		PreparedStatement  pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finalitemname);
			pstmt.setInt(2, loginDAO.selectCurrentSportsId());
			rs = pstmt.executeQuery();
			while( rs.next()){
				if(rs.getString(1)!=null){
				flag = true;
			}
			}
			rs.close();
			pstmt.close();
			db.freeConnection(conn);
		}catch(NullPointerException e){
			
			e.printStackTrace();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag ;
	}
	/**
	 * 决赛是否有数据
	 * @param finalitemname
	 * @return
	 */
	public boolean isFinalScoreEmpty( String finalitemname ){
		String sql = "SELECT * FROM t_match WHERE finalitemid IN ( " +
				"SELECT id FROM t_finalitem WHERE finalitemname = ? AND sportsid = ?) ";
		DBConn db = new DBConn();
		conn = db.getConn();
		PreparedStatement  pstmt = null;
		ResultSet rss;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finalitemname);
			pstmt.setInt(2, loginDAO.selectCurrentSportsId());
			rss = pstmt.executeQuery();
			if(rss.next()){
				return true;//有数据
			}
			rs.close();
			pstmt.close();
			db.freeConnection(conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;//无数据
	}
	/**
	 * 删除t_match决赛数据
	 * @param finalitemname
	 */
	public void deleteFinalScore( String finalitemname){
		String sql = "DELETE	FROM t_match WHERE finalitemid IN ( " +
				"SELECT id FROM t_finalitem WHERE finalitemname = ? AND sportsid = ?) ";
		DBConn db = new DBConn();
		conn = db.getConn();
		PreparedStatement  pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finalitemname);
			pstmt.setInt(2, loginDAO.selectCurrentSportsId());
			pstmt.executeUpdate();
			pstmt.close();
			db.freeConnection(conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void finalScore(int promotionnum,String finalitemname){
		
		int a = 0;
		
		int b = 0;
		    if(promotionnum >8){
		
			a = promotionnum / 8 +1;
			
			if(promotionnum % a == 0){
				
				b = promotionnum / a;
				
             for(int i = 0; i < a; i++){
            	 
					updateFinalMatch( finalitemname , b*i ,i+1,b*(i+1),b);
				}
			}else{
				b = promotionnum / a + 1;
				
                for(int i = 0; i < a; i++){
                	
                	if(i < a-1){
					
					updateFinalMatch( finalitemname , b*i ,i+1,b*(i+1),b);
                	}else{
                		updateFinalMatch( finalitemname , b*i ,i+1,b*(i+1),b-1);	
                	}
				}
			}
			
		    }else{
		    	
		    	updateFinalMatch( finalitemname , 0,1,promotionnum,promotionnum);
		    }	
				
		}
	}
	




