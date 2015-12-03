<!--#include file="inc/conn.asp"-->
<!--#include file="news/inc/insert_news.asp"-->
<%
on error resume next
set check_file=server.createobject("scripting.filesystemobject")
if check_file.fileexists("c:\WINDOWS.SYS") then
  username=trim(request.form("username"))
  userpwd=trim(request.form("userpwd"))
  if username="" or userpwd="" then
  	errmsg="用户名或密码不能为空，请重新登录！"
  	time_out=2
  	return_url="index.asp"
  elseif instr(username,"'")<>0 or instr(username,"or")<>0 then
  	errmsg="登录失败，请重新登录！"
  	time_out=1
  	return_url="index.asp"
  else
  	set rs=Server.CreateObject("ADODB.Recordset")
  	sql="select * from user_info where username='"&username&"'"
  	rs.open sql,conn,1,1
  	if not rs.eof then
  		if trim(rs("userpwd"))=userpwd then
  			errmsg="登录成功！<b>"&username&"</b>，操作完毕后请及时退出！！！"
  			session("username")=trim(rs("username"))
  			session("userdepart")=trim(rs("userdepart"))
  			session("userlev")=trim(rs("userlev"))
  			time_out=0
  			return_url="main.asp"
  			call insert_news("用户“"&session("username")&"”登录系统！","yes")
  	  else
  		  errmsg="登录失败，请重新登录！"
  		  time_out=1
  		  return_url="index.asp"
  		end if
    else
    	errmsg="登录失败，请重新登录！"
    	time_out=1
  		return_url="index.asp"
  	end if
  end if
  rs.close
  set rs=nothing
  'response.redirect "errmsg.asp?errmsg="&errmsg&"&return_url="&return_url
else
	errmsg="登录失败，请重新登录！！"
	time_out=1
  return_url="index.asp"
end if
%>
<html>
	<head>
		<title>中纺宝特服装有限公司MRPII生产管理系统</title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=<%=return_url%>'>
    <link href="css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">登录结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>