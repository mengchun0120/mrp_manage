<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
worker_name=trim(request("worker_name"))
is_del=trim(request("is_del"))

if is_del="ȡ ��" then
  response.redirect "edit_worker.asp"
  response.end
end if

set rs=Server.CreateObject("ADODB.Recordset")
sql="delete from worker_info where worker_name='"&worker_name&"'"
rs.open sql,conn,1,3
rs.close
set rs=nothing
errmsg=worker_name&"����Ϣɾ���ɹ���"
return_url="edit_worker.asp"
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
  			<td class="table_title">ɾ�����</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>