<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))

set rs=Server.CreateObject("ADODB.Recordset")
sql="update notify_info set state='¼�����' where notify_no='"&notify_no&"'"
rs.open sql,conn,1,3
rs.close
set rs=nothing

errmsg="����֪ͨ����"&notify_no&"��¼����ɣ�"
return_url="list_notify.asp"
time_out=0
'response.end
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
  			<td class="table_title">������</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>