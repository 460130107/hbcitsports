/**
* Copyright(C) 2012, 河北工业职业技术学院计算机系2010软件专业.
*
* 模块名称：     赛前设置
* 子模块名称：   部门管理
*
* 备注：
*
* 修改历史：
* 2012-7-16	0.1		李玮		新建
*/
package cn.edu.hbcit.smms.servlet.gamesetservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import cn.edu.hbcit.smms.services.gamesetservices.SportsService;

/**
 * 获取部门信息By id类
 * 简要说明:
 * @author 李玮
 * @version 1.00  2012-7-16下午10:38:53	新建
 */

public class GetDepartInfoByIdServlet extends HttpServlet {

	protected final Logger log = Logger.getLogger(GetDepartInfoByIdServlet.class.getName());
	/**
	 * Constructor of the object.
	 */
	public GetDepartInfoByIdServlet() {
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

		response.setContentType("text/html");
		SportsService ss = new SportsService();
		ArrayList list = new ArrayList();
		String departmentId = request.getParameter("dpid");
		log.debug("部门ID：" + departmentId);
		list = ss.selectDepartmentInfoById(departmentId);
		
		if( list != null){
			//log.debug("list not NULL !!!");
			request.setAttribute("dpinfo", list);
			request.getRequestDispatcher("/set_departmentupdate.jsp").forward(request, response);
		}else{
			log.debug("selectDepartmentInfoById(departmentId)为NULL");
		}
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
