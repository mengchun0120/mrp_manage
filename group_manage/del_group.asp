<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
group_name=trim(request("group_name"))
is_del=trim(request("is_del"))

if is_del="取 消" then
  response.redirect "edit_group.asp"
  response.end
end if

set rs=Server.CreateObject("ADODB.Recordset")
sql="delete from group_info where group_name='"&group_name&"'"
rs.open sql,conn,1,3
rs.close
set rs=nothing
errmsg=group_name&"的信息删除成功！"
return_url="edit_group.asp"
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