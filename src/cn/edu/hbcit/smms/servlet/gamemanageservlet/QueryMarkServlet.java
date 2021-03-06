package cn.edu.hbcit.smms.servlet.gamemanageservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.edu.hbcit.smms.dao.gamemanagedao.QueryMark;
import cn.edu.hbcit.smms.pojo.QueryMarkPoJo;
import cn.edu.hbcit.smms.services.gamemanageservices.QueryMarkServices;

public class QueryMarkServlet extends HttpServlet {
	
	/**
	 * Constructor of the object.
	 */
	public QueryMarkServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
//		int sportsId = Integer.parseInt(session.getAttribute("currSportsId").toString()); 
//		QueryMark qm1 = new QueryMark();
//		ArrayList items = qm1.selectGroup2Item(1, sportsId);
//		String marks = qm1.selectJifen(sportsId);
//		ArrayList boySql = qm1.getMarkSql(items, marks, sportsId);
//		qm1.updateBySql(boySql);
//		ArrayList gitems = qm1.selectGroup2Item(1, sportsId);
//		ArrayList gSql = qm1.getMarkSql(gitems, marks, sportsId);
//		qm1.updateBySql(gSql);
		
		////////////////以上为添加积分
		
		
		QueryMarkServices qm = new QueryMarkServices();
		boolean flag = qm.selectAllMarks();
		if(flag == false){                  //若t_mark表中没有记录,则插入学生总积分,若学生积分插入成功,则更新教工积分
			int i = qm.insertAllStuMarks();
			if(i>0){
				 qm.updateAllTeasMarks();
			}
			
		}else{
			qm.updateMarks();    //若t_mark表中已经有记录,则更新
		}
		
	    ArrayList allMarkInfo = qm.allMarkInfo();
	    ArrayList allTeachInfo = qm.allTeachMarkInfo();
	    //System.out.println(allMarkInfo.size()+"11111111111111111111111111111111");
	    session.setAttribute("allMarkInfo", allMarkInfo);
	    session.setAttribute("allTeachInfo", allTeachInfo);
		response.sendRedirect("../mark.jsp");
		
	}
	

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
