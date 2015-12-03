<!--#include file="../inc/conn.asp"-->
<%

on error resume next
time_out=2
order=request.querystring("conid")
itemk=request.querystring("kuanid")
if order="" then
	order=request.form("conid")
end if
if itemk="" then
	itemk=request.form("kuanid")
end if
set rs0=conn.execute("select state from order_info where order_no='"&order&"'")
if (instr(rs0("state"),"单耗录入")<>0 and instr(rs0("state"),trim(session("username")))=0) then
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=show_item.asp'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">结果</td>
  		</tr>
  		<tr>
  			<td align="center">此订单单耗正有人修改稍后请重试！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
else
	str="单耗录入"&","&session("username")
  set upr=conn.execute("update order_info set state='"&str&"' where order_no='"&order&"'")
  response.redirect ("ifc_dhjs.asp?conid="&order&"&kuanid="&itemk&"")
end if%>