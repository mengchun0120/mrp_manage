<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
on error resume next
userpwd_old=trim(request.form("userpwd_old"))
userpwd_new=trim(request.form("userpwd_new"))
userpwd_conform=trim(request.form("userpwd_conform"))

if userpwd_old="" or userpwd_new="" or userpwd_conform="" or userpwd_new<>userpwd_conform then
	errmsg="密码填写错误，请重新填写！"
	return_url="edit_pwd.asp"
	time_out=1
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from user_info where username='"&session("username")&"'"
	rs.open sql,conn,1,1
	if rs("userpwd")<>userpwd_old then
		errmsg="密码填写错误，请重新填写！！"
		return_url="edit_pwd.asp"
		time_out=1
	else
  	  	set rs2=Server.CreateObject("ADODB.Recordset")
	  	sql2="update user_info set userpwd='"&userpwd_new&"' where username='"&session("username")&"'"
	  	rs2.open sql2,conn,1,3
	 	rs2.close
    		set rs2=nothing
  		errmsg=session("username")&"的密码信息修改成功！"
		return_url="edit_pwd.asp"
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
  			<td class="table_title">修改结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>