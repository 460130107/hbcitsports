package cn.edu.hbcit.smms.services.gamesetservices;

import java.util.ArrayList;

import cn.edu.hbcit.smms.dao.gamesetdao.SportsDAO;
import cn.edu.hbcit.smms.util.UtilTools;

public class SportsService {
	SportsDAO sp = new SportsDAO();
	UtilTools ut = new UtilTools();
	
	/**
	 * 获取所有运动会信息
	 * @return ArrayList
	 */
	public ArrayList selectSportsInfo(){
		return sp.selectSportsInfo();
	}
	
	/**
	 * 获取指定ID的运动会信息
	 * @param String sportsId
	 * @return
	 */
	public ArrayList selectSportsInfoById(String sportsId){
		if(ut.isNumeric(sportsId)){
			return sp.selectSportsInfoById(Integer.parseInt(sportsId));
		}else{
			return null;
		}
	}
	/**
	 * 获取指定ID的部门信息
	 * @param int departmentId
	 * @return
	 */
	public ArrayList selectDepartmentInfoById(String departmentId){
		if(ut.isNumeric(departmentId)){
			return sp.selectDepartmentInfoById(Integer.parseInt(departmentId));
		}else{
			return null;
		}
	}
	/**
	 * 设置当前运动会
	 * @param userId
	 * @return boolean
	 */
	public boolean setCurrSports(String spId){
		boolean flag = false;
		if(ut.isNumeric(spId)){
			flag = sp.setCurrSports(Integer.parseInt(spId));
		}
		return flag;
	}
	
	/**
	 * 新增运动会
	 * @param sportsName
	 * @param begin
	 * @param end
	 * @param registEnd
	 * @param address
	 * @return
	 */
	public boolean addSports(String sportsName, String begin, String end, String registEnd, String address){
		return sp.addSports(sportsName, begin, end, registEnd, address);
	}
	
	/**
	 * 修改运动会By id
	 * @param id
	 * @param sportsName
	 * @param begin
	 * @param end
	 * @param registEnd
	 * @param address
	 * @return
	 */
	public boolean updateSports(String id,String sportsName, String begin, String end, String registEnd, String address){
		if(ut.isNumeric(id)){
			return sp.updateSports(Integer.parseInt(id), sportsName, begin, end, registEnd, address);
		}else{
			return false;
		}
	}
	/**
	 * 修改部门信息By id
	 * @param departId
	 * @param departName
	 * @param departShortName
	 * @param departType
	 * @return
	 */
	public boolean updateDepartment(String departId, String departName, String departShortName, String departType){
		if(ut.isNumeric(departId) && ut.isNumeric(departType)){
			return sp.updateDepartment(Integer.parseInt(departId), departName, departShortName, Integer.parseInt(departType));
		}else{
			return false;
		}
	}
	
	/**
	 * 删除指定id的运动会
	 * @param id
	 * @return
	 */
	public boolean removeSports(String id){
		if(ut.isNumeric(id)){
			return sp.removeSports(Integer.parseInt(id));
		}else{
			return false;
		}
	}
	/**
	 * 获取所有部门信息
	 * @return
	 */
	public ArrayList selectDepartmentInfo(){
		return sp.selectDepartmentInfo();
	}
	/**
	 * 获取指定届次的参赛部门ID
	 * @return
	 */
	public ArrayList selectDepartmentInfo(int sportsId){
		return sp.selectDepartmentInfo(sportsId);
	}
	
	/**
	 * 新增单位/部门
	 * @param departName
	 * @param departShortName
	 * @param departType
	 * @return
	 */
	public boolean addDepartment(String departName, String departShortName, String departType){
		if(ut.isNumeric(departType)){
			return sp.addDepartment(departName, departShortName, Integer.parseInt(departType));
		}else{
			return false;
		}
		
	}
}
