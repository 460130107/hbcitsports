<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>

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
                         <td width="94%" valign="bottom"><span class="pageTitle">��ǰ����-->�����¼</span></td>
                         </tr>
                     </table>
                 </td>
            </tr>
            <tr>
            	<td colspan="9" align="center"><b>�����ɼ�¼��</b></td>
            </tr>
        </table>
        
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" class="stripe_tb">
        	<tr><td colspan="5">100�׾����ɼ���</td></tr>
            <tr class="tableTitle" align="center" >
            	<td>����</td>
                <td>����</td>
                <td>����/����˳��</td>
                <td>ϵ��</td>
                <td>�ɼ�</td>
            </tr>
            <tr class="tableContent">
            	<td>001</td>
                <td>�޹���</td>
                <td>1</td>
                <td>�����ϵ</td>
                <td>100</td>
            </tr>
            <tr class="tableContent">
            	<td>001</td>
                <td>�޹���</td>
                <td>1</td>
                <td>�����ϵ</td>
                <td>100</td>
            </tr>
            <tr class="tableContent">
            	<td>001</td>
                <td>�޹���</td>
                <td>1</td>
                <td>�����ϵ</td>
                <td>100</td>
            </tr>
            <tr><td colspan="5"><input type="button" value="�ύ"/><input type="button" value="��ӡ"/></td></tr>
        </table>
    </div>
  </body>
</html>
