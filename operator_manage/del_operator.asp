<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
on error resume next
username=trim(request("username"))
is_del=trim(request("is_del"))

if is_del="取 消" then
  response.redirect "edit_operator.asp"
  response.end
end if

set rs=Server.CreateObject("ADODB.Recordset")
sql="delete from user_info where username='"&username&"'"
rs.open sql,conn,1,3
rs.close
set rs=nothing
errmsg=username&"的信息删除成功！"
return_url="edit_operator.asp"
time_out=0
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
  			<td class="table_title">删除结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>