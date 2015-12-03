<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
serial_no=trim(request("serial_no"))
goto_url=trim(request("goto_url"))
suborder_no=trim(request("suborder_no"))
is_del=trim(request("is_del"))

if is_del="取 消" then
	response.redirect goto_url&"?order_no="&order_no&"&item_id="&item_id&"&serial_no="&serial_no
  response.end
end if
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="delete from suborder_info where suborder_no='"&suborder_no&"'"
rs2.open sql2,conn,1,3
rs2.close
set rs2=nothing
errmsg="该订单项信息删除成功！"
return_url=goto_url&"?order_no="&order_no&"&item_id="&item_id&"&serial_no="&serial_no
time_out=0
'response.redirect "../errmsg.asp?errmsg="&errmsg&"&return_url="&return_url
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