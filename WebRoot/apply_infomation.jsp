<%@ page language="java" import="java.util.*,cn.edu.hbcit.smms.pojo.SelPlayerByGroupPojo" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>报名情况查询</title>
   	<link href="${pageContext.request.contextPath }/css/subcss.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.6.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/zDialog_inner.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/zDrag.js"></script>
<script type="text/javascript">
$(document).ready(function(){
			 $(".stripe_tb tr").mouseover(function(){ //如果鼠标移到class为stripe_tb的表格的tr上时，执行函数
			 $(this).addClass("over");}).mouseout(function(){ //给这行添加class值为over，并且当鼠标一出该行时执行函数
			 $(this).removeClass("over");}) //移除该行的class
			 $(".stripe_tb tr:even").addClass("alt"); //给class为stripe_tb的表格的偶数行添加class值为alt		
		});
</script>

<script type="text/javascript">
//隔行变色

<%
	int perMan = Integer.parseInt(session.getAttribute("perMan").toString());
	int perDepartment = Integer.parseInt(session.getAttribute("perDepartment").toString());
%>

//********************************韩鑫鹏
<%
int[][] itemInfo = null;
if(request.getAttribute("itemInfo")!=null){
	itemInfo =(int[][])request.getAttribute("itemInfo");
	out.print("var gr2items = new Array();");
	
	for(int iNum = 0;iNum<itemInfo.length;iNum++ ){
		out.print("gr2items["+iNum+"] = new Array(3);");
		out.print("gr2items["+iNum+"][0] = "+itemInfo[iNum][0]+";");
		out.print("gr2items["+iNum+"][1] = "+itemInfo[iNum][1]+";");
		out.print("gr2items["+iNum+"][2] = "+itemInfo[iNum][2]+";");
	}
	
}
%> 
//********************************韩鑫鹏	
//判断每项限报6人
<%
if(request.getAttribute("itemList")!=null&&request.getAttribute("groupList")!=null){
	ArrayList itemlist = (ArrayList)request.getAttribute("itemList");
	ArrayList grouplist = (ArrayList)request.getAttribute("groupList");
	//System.out.println(itemlist.size());
	int[] itemid = new int[itemlist.size()];
	String[] itemtypes = new String[itemlist.size()];
	//var itemSix = new Array();
	out.println("var itemSix = new Array();");
	for(int j = 0;j<itemlist.size();j++ ){
		SelPlayerByGroupPojo item = (SelPlayerByGroupPojo)itemlist.get(j);
		itemid[j] = item.getItemid();
		itemtypes[j] = item.getItemtype();
		out.println("itemSix["+j+"] = "+ item.getItemid()+";");
		//itemSix[j] = item.getItemid();
	}

	//var groupId = new Array();
	out.println("var groupId = new Array();");
	//var groupName = new Array();
	out.println("var groupName = new Array();");
	for(int j = 0;j<grouplist.size();j++ ){
		SelPlayerByGroupPojo group = (SelPlayerByGroupPojo)grouplist.get(j);
		//groupId[j] = group.getId();
		out.println("groupId["+j+"] = "+ group.getId()+";");
		out.println("groupName["+j+"] = \""+ group.getGroupname()+"\";");
		//groupName[j] = group.getGroupname();
	}
}
%>

function showSelectValue(){ 

 var matchgroup = document.getElementById("matchgroup").value;
	if(matchgroup=="0"||matchgroup=="1"){
		document.forms[0].submit();
		
	}else{
		Dialog.alert("请选择参赛组别"+matchgroup);
		return false;
			}
}

//限制每人项目个数
function checkItem(obj){
	var falgqq = 0;
	var thisname = obj.name;
	//alert(thisname);
	var arr = document.getElementsByName(thisname);
	var count = 0;
	for(var i=0; i<arr.length; i++){
		var temp;
		temp = arr[i].id.split("#");
		if( arr[i].checked == true && temp[1] != "3"){
			count++;
		}
	}
	if(count ><%=perMan%>){
		Dialog.alert("除接力比赛外，每人限报<%=perMan%>项！");
		obj.checked = false;
	}
	//********************************韩鑫鹏
	
	var eItem = obj.value;
	var myid = parseInt(eItem);
	//alert("myid"+myid);
	var groupid = thisname.replace('checkbox_',"");
	groupid = "select_"+groupid;
	//alert("groupid"+groupid);
	var sex=parseInt(document.getElementById(groupid).value);
	//alert(sex);
	for (var itNum = 0; itNum < gr2items.length;itNum++){
	//alert('leijiazhiqian'+gr2items[itNum][2]);
		if(gr2items[itNum][0]==sex && gr2items[itNum][1]==myid){
		falgqq = 1;
			if(obj.checked){
				gr2items[itNum][2]++;
				//alert(gr2items[itNum][2]);
				if(gr2items[itNum][2] > <%=perDepartment%>){
					
					Dialog.alert("该项目超过<%=perDepartment%>人");
					obj.checked = false;
					gr2items[itNum][2]--;
				}
				break;
			}else{
				//alert(gr2items[itNum][2]);
				gr2items[itNum][2]--;
				//alert(gr2items[itNum][2]);
				break;
			}
		}
	}
	if(falgqq == 0){
		Dialog.alert("该组别没有该项目");
		obj.checked = false;
	}
}
function checkSex(old,obj){
	var thisname = obj.id;
	var val = obj.value;
	var boxName = thisname.replace('select_',"");
	boxName = "checkbox_" + boxName;
	//alert(boxName);
	var arr = document.getElementsByName(boxName);
	for(var i=0; i<arr.length; i++){
		if( arr[i].checked == true){
			var temp;
			temp = arr[i].value;
			var myid = parseInt(temp);
			for (var itNum = 0; itNum < gr2items.length;itNum++){
				if(gr2items[itNum][0]==old && gr2items[itNum][1]==myid){
					gr2items[itNum][2]--;
					arr[i].checked = false;
					break;
				}
			}
		}
	}
}
//********************************韩鑫鹏
function submitCheck(){
	document.getElementById("hidselectGroup").value = document.getElementById("matchgroup").value
	var countOldMan = 0;
	var countOldWoman = 0;
	var countYoungMan = 0;
	var countYoungWoman = 0;
	var myobj=document.getElementsByName("hide");
	var itemNoPlus = new Array();
	var itemCountOldMan = new Array();
	var itemCountOldWoman = new Array();
	var itemCountYoungMan = new Array();
	var itemCountYoungWoman = new Array();
	if(myobj.length==0){
	 Dialog.alert("请选择参赛组别！");
		return false;
	}else{
	for(var i = 1;i <= myobj.length+1; i++){
		var num = document.getElementById("num_"+i).value;
		
		var name = document.getElementById("name_"+i).value;
		if(name == ""){
			Dialog.alert("姓名不能为空！");
			return false;
		}
		var group=document.getElementById("select_"+i).value;
		var itemid = document.getElementsByName("checkbox_"+i);
		
		var allitem = "";
		var checkednum = 0;
		for(var j=0;j < itemid.length; j++){
			if(itemid[j].checked){
				checkednum++;
			}
		}
		for(var j = 0,jj=0;j < itemid.length; j++){
			if(itemid[j].checked){
				allitem += itemid[j].value;
				if(jj != checkednum - 1){
					allitem += ";";
				}
				jj++;
			}
		}
		var allitems = allitem.split(";");
		if(allitems==""){
			Dialog.alert("项目不能为空！");
			return false;
		}
		
		var str = num+","+name+","+group+","+allitem;
		//alert(str);
		document.getElementById(i+"_cover").value=str;
		str = "";
		}
		
	
	for(var i=0;i<itemSix.length;i++){
		itemCountOldMan[i]=0;
		itemCountOldWoman[i]=0;
		itemCountYoungMan[i]=0;
		itemCountYoungWoman[i]=0;
	}
	for(var i = 0; i<myobj.length; i++){
		var arrGroup = myobj[i].value.split(",");	//{"20031","张三","教工青年男子组","2+3;4+5"}    11112,jjjjsssss,2,1;2
		var itemId = arrGroup[3].split(";");   //{"1","2"}
		for(var j=0 ;j<itemSix.length; j++){
			for(var k=0; k<itemId.length; k++){
				if(arrGroup[2] == groupId[0] && itemId[k]==itemSix[j]){
					itemCountOldMan[j]++;
				}else if(arrGroup[2] == groupId[1] && itemId[k]==itemSix[j]){
					itemCountOldWoman[j]++;
				}else if(arrGroup[2] == groupId[2] && itemId[k]==itemSix[j]){
					itemCountYoungMan[j]++;
				}else if(arrGroup[2] == groupId[3] && itemId[k]==itemSix[j]){
					itemCountYoungWoman[j]++;
				}
			}
		}
	}
	
	for(var i = 0;i<itemCountOldWoman.length;i++){
		if(itemCountOldMan[i] > <%=perDepartment%>){
			Dialog.alert(groupName[0]+"中有一些项目报名人数超过6人，请检查！");
			//Dialog.alert(groupName[0]+"中有一些项目报名人数超过6人，请检查！");
			return false;
		}
		if(itemCountOldWoman[i] > <%=perDepartment%>){
		Dialog.alert(groupName[1]+"中有一些项目报名人数超过6人，请检查！");
			//Dialog.alert(groupName[1]+"中有一些项目报名人数超过6人，请检查！");
			return false;
		}
		if(itemCountYoungMan[i] > <%=perDepartment%>){
			//Dialog.alert(groupName[2]+"中有一些项目报名人数超过6人，请检查！");
			Dialog.alert(groupName[2]+"中有一些项目报名人数超过6人，请检查！");
			return false;
		}
		if(itemCountYoungWoman[i] > <%=perDepartment%>){
			//Dialog.alert(groupName[3]+"中有一些项目报名人数超过6人，请检查！");
			Dialog.alert(groupName[3]+"中有一些项目报名人数超过6人，请检查！");
			return false;
		}
	}
	}
}
</script>
  </head>
  <body>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
   <td height="30">
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td height="24" bgcolor="#353c44"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
          <td width="6%" height="19" valign="bottom"><div align="center"><img src="${pageContext.request.contextPath }/images/tb.gif" width="14" height="14" /></div></td>
           <td width="94%" valign="bottom"><span class="pageTitle">赛事报名--><font color="yellow">${requestScope.departName }</font>报名情况查询</span></td>
        </tr>
     </table>
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
<!--内嵌表格 组别分类 begin-->
<form action="${pageContext.request.contextPath }/servlet/ApplyInfomationServlet?action=pageinf" method="post" name="form1" />
    <table width="100%" border="0">
    <tr>
    <td width="10%" scope="col" align="center">参赛组别            
    <%
    				String mat = (String)request.getAttribute("grouptypes");
    	%>
    	</td>
    <td width="10%" scope="col">
    <div class="centent">
    <div>
    <select id="matchgroup" name="matchgroup">
    		<option value="">-请选择-</option>      
            <%
    			try{
    				String match = (String)request.getAttribute("grouptypes");
    				if(match.equals("Y")){
    	%>
    	<c:forEach items="${requestScope.typeList}" var="gte">
    		<c:if test="${gte.grouptype==1}"><option value="1">学生组</option></c:if> 
          	<c:if test="${gte.grouptype==0}"><option value="0">教工组</option></c:if>
        </c:forEach>
    	<%
    				}else{
    					int grouptype = Integer.parseInt(match);
    					if(grouptype == 1){
    	%>
    	<c:forEach items="${requestScope.typeList}" var="gte">
    		<c:if test="${gte.grouptype==1}"><option value="1" selected>学生组</option></c:if> 
          	<c:if test="${gte.grouptype==0}"><option value="0">教工组</option></c:if>
        </c:forEach>
          <%
          				}
          				if(grouptype == 0){       				
          %>
          <c:forEach items="${requestScope.typeList}" var="gte">
          	<c:if test="${gte.grouptype==1}"><option value="1">学生组</option></c:if> 
          	<c:if test="${gte.grouptype==0}"><option value="0" selected>教工组</option></c:if>
          </c:forEach>
          <%
          				}
    					}
    			}catch( Exception e){
    				e.getStackTrace();
    			}
    %>  	
        </select></div>
   </div>
   </td>
   <td width="5%"><input type="button" name="query" id="query" value="查询" onclick="showSelectValue()"/></td>
   <td align="center">
   <span class="pageTitle"><a href="${pageContext.request.contextPath }/servlet/ApplyInfomationServlet?action=leader">查看修改<font color="blue">${requestScope.departName }</font>教练信息</a></span>
   </td>
   </tr>
  </table>
  </form>
<!--内嵌表格 组别分类 end-->  
 <!-- 显示运动员信息 -->
 <form  action="${pageContext.request.contextPath }/servlet/ApplyInfomationServlet?action=updateinf" method="post" onsubmit="return submitCheck();">
  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" class="stripe_tb">
    <tr class="tableTitle">
       <td width="4%" height="20"><div align="center"><span>运动员号</span></div></td>
       <td width="3%" height="20"><div align="center"><span>姓名</span></div></td>
       <td width="2%" height="20"><div align="center"><span>组别</span></div></td>
       <c:forEach items="${requestScope.itemList}" var="item">
	   	<td width="6%"  height="20"><div align="center"><span>${item.itemname }</span></div></td>
      </c:forEach>
       <td width="2%" height="20"><div align="center"><span>操作</span></div></td>
    </tr>
    <c:forEach items="${requestScope.groupPlayer}" var="player" begin="">
  	<tr class="tableContent">
         <td width="5%" height="20">
         <div align="center">
         <input type="hidden" name="hide" id="${player.playernumID}_cover" />
         <input id="num_${player.playernumID}" disabled="disabled" type="text" value="${player.playernum}" size="7"/>
         </div>
         </td>
         <td width="5%" height="20">
         <div align="center">
         <input id="name_${player.playernumID}" type="text" value="${player.playername}" size="7" />
         </div>
         </td>
         <td width="2%" height="20">
         <div align="center">
         <span>
         <select id="select_${player.playernumID}" name="select_${player.playernumID}" onclick="old=this.value" onchange="checkSex(old,this);">
           <c:forEach items="${requestScope.groupList}" var="grouplist">
           <option value="${grouplist.id}" <c:if test="${player.groupid eq grouplist.id}">selected="selected"</c:if>>${ grouplist.groupname }</option>             
           </c:forEach>             
         </select>
         </span>
         </div>
         </td>
         <% 	
         		ArrayList list = (ArrayList)request.getAttribute("itemList");
         		int itemids[] = new int[list.size()];
         		String itemtype[] = new String[list.size()];
         		for(int jj = 0;jj<list.size();jj++){
         			SelPlayerByGroupPojo item = (SelPlayerByGroupPojo)list.get(jj);
         			itemids[jj] = item.getItemid();
         			itemtype[jj] = item.getItemtype();
         		}
         		int ii = 0;
         %>
        <c:forEach items="${player.items}" var="checked">
         <td width="6%" height="20"><div align="center">
         <span>
         <input onchange="checkItem(this)" type="checkbox" id="<%=itemids[ii]%>#<%=itemtype[ii]%>"  name="checkbox_${player.playernumID}" value="<%=itemids[ii]%>" ${checked}/>
         <%ii += 1; %>
         </span></div></td>
         </c:forEach>
         <td><a href="${pageContext.request.contextPath }/servlet/ApplyInfomationServlet?action=delete&playernum=${player.playernum}">删除</a></td>
   	</tr>
   	</c:forEach>
  </table>
  <div align="center">
  <input type="hidden" name="matchgroup" id="hidselectGroup" value="" />
  <span><input type="submit" name="button" id="button"  style="width:80px;height:30px;" value="修改" /> </span>
  </div>
 </form>
</td>
</tr>
</table>
<!-- 显示运动员信息结束-->
  </body>
</html>
