<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
on error resume next

username=trim(request.form("username"))
userpwd=trim(request.form("userpwd"))
userdepart=trim(request.form("userdepart"))
userlev=trim(request.form("userlev"))

if username="" or userpwd="" then
	errmsg="所填写各项均不能为空，请重新填写！"
	return_url="input_operator.asp"
	time_out=2
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from user_info where username='"&username&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="该用户名重复，请更换其他的用户名！"
		return_url="input_operator.asp"
		time_out=2
	else
  	  	set rs2=Server.CreateObject("ADODB.Recordset")
	  	sql2="insert into user_info (username,userpwd,userdepart,userlev) values ('"&username&"','"&userpwd&"','"&userdepart&"','"&userlev&"')"
	  	rs2.open sql2,conn,1,3
	 	rs2.close
    		set rs2=nothing
  		errmsg=username&"的信息录入成功！"
		return_url="input_operator.asp"
		time_out=0
	end if
	rs.close
  	set rs=nothing
end if
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=<%=return_url%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">录入结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>