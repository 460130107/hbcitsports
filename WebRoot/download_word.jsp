<%@page language="java" import="java.net.URLEncoder,java.io.*,java.net.URLDecoder" contentType="application/x-msdownload" pageEncoding="gb2312"%>   
<!-- ��ҳ���������������ʱʵ�֣�ʹ���ļ�����ʽ������Դ        -->
<!-- ��СӢ  2012-9-19       -->
<% String filePath = request.getSession().getServletContext().getRealPath("/"); %>
<%    
		  //�����ļ�����ʱ�����ļ�������ķ�ʽ����    
		  //����response.reset()���������еģ�>���治Ҫ���У��������һ����    
		   
		  response.reset();//���Լ�Ҳ���Բ���    
		  response.setContentType("application/x-download");    
		  //String file = (String)request.getParameter("file");
		  String file = filePath;
		  String fileName = URLDecoder.decode((String)request.getParameter("fileName"),"UTF-8");
		  System.out.println("111....."+file);
          System.out.println("222....."+fileName);
          if(file !=null && fileName !=null){
		  String filedownload = file + fileName;    
		  String filedisplay =  new String(fileName.getBytes("gb2312"), "iso8859-1");;        
		  response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);    
		   
		  java.io.OutputStream outp = null;    
		  java.io.FileInputStream in = null;    
		  try    
		  {    
		  outp = response.getOutputStream();    
		  in = new FileInputStream(filedownload);    
		   
		  byte[] b = new byte[1024];    
		  int i = 0;    
		   
		  while((i = in.read(b)) > 0)    
		  {    
		  outp.write(b, 0, i);    
		  }    
		//      
		outp.flush();    
		//Ҫ���������仰������ᱨ��    
		//java.lang.IllegalStateException: getOutputStream() has already been called for //this response      
		out.clear();    
		out = pageContext.pushBody();    
		}    
		  catch(Exception e)    
		  {    
		  System.out.println("Error!");    
		  e.printStackTrace();    
		  }    
		  finally    
		  {    
		  if(in != null)    
		  {    
		  in.close();    
		  in = null;    
		  }    
		//���ﲻ�ܹر�      
		//if(outp != null)    
		  //{    
		  //outp.close();    
		  //outp = null;    
		  //}    
		  }  }
		%>  