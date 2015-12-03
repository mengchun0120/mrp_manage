<!--#include file="../inc/conn.asp"-->
<%

on error resume next
order=request.querystring("conid")
itemk=request.querystring("kuanid")
if order="" then
	order=request.form("conid")
end if
if itemk="" then
	itemk=request.form("kuanid")
end if
set rs0=conn.execute("select state from order_info where order_no='"&order&"'")
if instr(rs0("state"),"单耗录入")<>0 then
	time_out=2
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
  			<td align="center">此订单单耗正有人录入稍后请重试！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
else
  response.redirect ("ifc_checkamount.asp?conid="&order&"&kuanid="&itemk&"")
end if%>