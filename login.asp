<!--#include file="inc/conn.asp"-->
<!--#include file="news/inc/insert_news.asp"-->
<%
on error resume next
set check_file=server.createobject("scripting.filesystemobject")
if check_file.fileexists("c:\WINDOWS.SYS") then
  username=trim(request.form("username"))
  userpwd=trim(request.form("userpwd"))
  if username="" or userpwd="" then
  	errmsg="�û��������벻��Ϊ�գ������µ�¼��"
  	time_out=2
  	return_url="index.asp"
  elseif instr(username,"'")<>0 or instr(username,"or")<>0 then
  	errmsg="��¼ʧ�ܣ������µ�¼��"
  	time_out=1
  	return_url="index.asp"
  else
  	set rs=Server.CreateObject("ADODB.Recordset")
  	sql="select * from user_info where username='"&username&"'"
  	rs.open sql,conn,1,1
  	if not rs.eof then
  		if trim(rs("userpwd"))=userpwd then
  			errmsg="��¼�ɹ���<b>"&username&"</b>��������Ϻ��뼰ʱ�˳�������"
  			session("username")=trim(rs("username"))
  			session("userdepart")=trim(rs("userdepart"))
  			session("userlev")=trim(rs("userlev"))
  			time_out=0
  			return_url="main.asp"
  			call insert_news("�û���"&session("username")&"����¼ϵͳ��","yes")
  	  else
  		  errmsg="��¼ʧ�ܣ������µ�¼��"
  		  time_out=1
  		  return_url="index.asp"
  		end if
    else
    	errmsg="��¼ʧ�ܣ������µ�¼��"
    	time_out=1
  		return_url="index.asp"
  	end if
  end if
  rs.close
  set rs=nothing
  'response.redirect "errmsg.asp?errmsg="&errmsg&"&return_url="&return_url
else
	errmsg="��¼ʧ�ܣ������µ�¼����"
	time_out=1
  return_url="index.asp"
end if
%>
<html>
	<head>
		<title>�зı��ط�װ���޹�˾MRPII��������ϵͳ</title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=<%=return_url%>'>
    <link href="css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">��¼���</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>