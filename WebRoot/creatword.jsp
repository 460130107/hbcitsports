<%@ page language="java" import="java.util.*,java.net.URLEncoder" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		<link href="css/subcss.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.6.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/zDialog_inner.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/zDrag.js"></script>
		<script type="text/javascript">
//隔行变色
	$(document).ready(function(){
			
			 $(".stripe_tb tr").mouseover(function(){ //如果鼠标移到class为stripe_tb的表格的tr上时，执行函数
			 $(this).addClass("over");}).mouseout(function(){ //给这行添加class值为over，并且当鼠标一出该行时执行函数
			 $(this).removeClass("over");}) //移除该行的class
			 $(".stripe_tb tr:even").addClass("alt"); //给class为stripe_tb的表格的偶数行添加class值为alt
			
		});
</script>
	<!-- 	<script type="text/javascript">

		function checkword(obj)
		{
		    var id = obj.id;
			
		    $.ajax({
			url:"${pageContext.request.contextPath}/servlet/WordDemoServlet",
				type:'post',
				data:'id='+id,
				dataType:"html",
				success:function(mm){
							var revalue=mm.replace(/\r\n/g,'');
							if(revalue=="success"){
								Dialog.alert("生成成功!");
								
							}
							else{
								Dialog.alert("生成失败!");
								}
						}
		});
		}
		
	</script>	
		
		<script type="text/javascript">
		

       function checkfile(obj){
			var fileName = obj.id;
			
			$.ajax({
					url :"${pageContext.request.contextPath }/servlet/DownSuccessServlet",
					type : 'post',
					data : 'fileName='+fileName,
					//data:{username:username},
									
					success :function(mm){
							var revalue=mm.replace(/\r\n/g,'');
							if(revalue=="success")
							{
								Dialog.alert("文件不存在，请先生成文件！");
							}
							else{
								location.replace("download_word.jsp?fileName="+fileName);
							}
						}
				});	
		}
		
		
		 -->
		 <script type="text/javascript">
		 function createWord(obj){
		    
		   // alert(obj.id);
		    window.location.href="${pageContext.request.contextPath }/servlet/WordDemoServlet?id="+obj.id;
		   
		 
		 }
		 </script>
		 
</head>

	<body>
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="30">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="24" bgcolor="#353c44">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="6%" height="19" valign="bottom">
														<div align="center">
															<img src="images/tb.gif" width="14" height="14" />
														</div>
													</td>
													<td width="94%" valign="bottom">
														<span class="pageTitle">秩序册管理-->秩序册</span>
													</td>
												</tr>
											</table>
										</td>
										<td>

										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<!--内嵌表格begin-->
					<table width="55%" border="0" cellpadding="0" cellspacing="0" bgcolor="#a8c7ce" class="stripe_tb" align="center">
						<tr >
							<td colspan="3" align="center" style="fontsize:20px;">
							  <strong>秩序册						    </strong></td>
					  </tr>

						<tr class="tableContent" >
							<td>
								大会安排
							</td>

							<td>
								<input type="button" id="1" value="生成word文档" onclick="createWord(this)"/>
							</td>
						</tr>
						<tr class="tableContent" >
							<td>
								竞赛分组
							</td>
							<td>
								<input type="button" id="2" value="生成word文档" onclick="createWord(this)"/>
							</td>
						</tr>
						<tr class="tableContent" >
							<td>
								运动员信息
							</td>
							<td>
								<input type="button" id="3" value="生成word文档" onclick="createWord(this)"/>
							</td>
						</tr>
						<tr class="tableContent" >
							<td>
								运动会记录及学生裁判名单
							</td>
							<td>
								<input type="button" id="4" value="生成word文档" onclick="createWord(this)"/>
							</td>
						</tr>
					</table>
					<!--内嵌表格end-->

				</td>
			</tr>
		</table>
		<br />

	</body>
</html>