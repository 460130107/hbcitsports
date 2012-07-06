<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>inputscore.jsp</title>
    <link href="css/subcss.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
<script type="text/javascript">
//���б�ɫ
	$(document).ready(function(){
			
			 $(".stripe_tb tr").mouseover(function(){ //�������Ƶ�classΪstripe_tb�ı���tr��ʱ��ִ�к���
			 $(this).addClass("over");}).mouseout(function(){ //���������classֵΪover�����ҵ����һ������ʱִ�к���
			 $(this).removeClass("over");}) //�Ƴ����е�class
			 $(".stripe_tb tr:even").addClass("alt"); //��classΪstripe_tb�ı���ż�������classֵΪalt
			
		});
		
		function gpchange(){
			var option = $("#group").find("option:selected").text()
			$.ajax({
			
				url:"${pageContext.request.contextPath}/servlet/GetConditonServlet?action=itmecondBygp",
				type : "get",
				contentType : "application/json;charset=utf-8",
				dataType : "json",
				data:{option:option},
				success :function(json){
				
				//var inhtml = "<option>";
				for(int i = 0;i<json.contents.length;i++){
				
					inhtml += "<option>"+json.contents[i].option+"</option>";
					
				}
				
				$("#group").html(inhtml);
				
			},
				error : function(xhr, status, errorThrown) {
						alert("errorThrown=" + errorThrown);
					}
					
			});
		}
</script>
  </head>
  
  <body>
    <div>
    	<table  width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        	<tr>
            	<td bgcolor="#353c44" colspan="9"  height="19">
                    <table>
                    	<tr>
                         <td width="6%"  valign="bottom"><div align="center"><img src="images/tb.gif" width="14" height="14" /></div></td>
                         <td width="94%" valign="bottom"><span class="pageTitle">��ǰ����-->�ɼ�¼��</span></td>
                         </tr>
                     </table>
                 </td>
            </tr>
            <tr>
            	<td colspan="7" align="center"><b>�ɼ�¼��</b></td>
            </tr>
            <tr class="tableTitle">
            	<td height="20" colspan="7">��������</td>
            </tr>
            <tr class="tableTitle" align="center">
            	<td height="20">���</td>
                <td height="20">
                	<select onChange="gpchange()">
                    	<option>--��ѡ��--</option>
                    	<c:forEach items="${sessionScope.conditionlist}" var="gp">
                        	<option>${gp.groupname }</option>
                        </c:forEach>
                    </select>
                </td>
                <td height="20">��Ŀ����</td>
                <td height="20">
                	<select id="group">
                    	<option>--��ѡ��--</option>
                    	<c:forEach items="${sessionScope.conditionlist1}" var="item">
                        	<option>${item.itemname}</option>
                        </c:forEach>
                    </select>
                </td>
                <td height="20">����</td>
                <td height="20"> 
                	<select>
                    	<option>--��ѡ��--</option>
                        <option>Ԥ��</option>
                        <option>����</option>
                        <option>��/Ԥ��</option>
                    </select>
                </td>
                <td><input type="button" value="¼��ɼ�"/></td>
            </tr>
        </table>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce"  class="stripe_tb">
            <tr class="tableTitle" align="center" >
            	<td width="20%">����</td>
                <td width="20%">����</td>
                <td width="20%">����/����˳��</td>
                <td width="40%">�ɼ�</td>
            </tr>
            <tr><td colspan="4"><input type="button" value="�ύ"/><input type="button" value="����"/></td></tr>
        </table>
    </div>
  </body>
</html>
