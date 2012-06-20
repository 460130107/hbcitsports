package cn.edu.hbcit.smms.services.gamesetservices;

import java.util.ArrayList;

import cn.edu.hbcit.smms.dao.gamesetdao.SportsDAO;
import cn.edu.hbcit.smms.util.UtilTools;

public class SportsService {
	SportsDAO sp = new SportsDAO();
	UtilTools ut = new UtilTools();
	
	/**
	 * 获取运动会信息
	 * @return ArrayList
	 */
	public ArrayList selectSportsInfo(){
		return sp.selectSportsInfo();
	}
	
	/**
	 * 设置当前运动会
	 * @param userId
	 * @return boolean
	 */
	public boolean setCurrSports(String userId){
		boolean flag = false;
		if(ut.isNumeric(userId)){
			flag = sp.setCurrSports(Integer.parseInt(userId));
		}
		return flag;
	}
}
