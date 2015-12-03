<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
serial_no=trim(request("serial_no"))
goto_url=trim(request.form("goto_url"))
suborder_no=trim(request.form("suborder_no"))
suborder_color=trim(request.form("suborder_color"))
suborder_size=trim(request.form("suborder_size"))
suborder_inlen=trim(request.form("suborder_inlen"))
if suborder_inlen="" then
	suborder_inlen=0
end if
suborder_amount=trim(request.form("suborder_amount"))
add_amount=round(suborder_amount*0.05)
if suborder_color="" or suborder_size="" or suborder_amount="" then
	errmsg="必填项均不能为空，请重新填写！"
	return_url=goto_url&"?order_no="&order_no&"&item_id="&item_id&"&serial_no="&serial_no
	time_out=1
	'response.write return_url&"<br>"&item_id&"<br>"&order_no
'response.end
else
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="update suborder_info set suborder_color='"&suborder_color&"',suborder_size='"&suborder_size&"',suborder_inlen="&suborder_inlen&",suborder_amount="&suborder_amount&",add_amount="&add_amount&",last_modify='"&now()&"' where suborder_no='"&suborder_no&"'"
  'response.write sql
  'response.end
  rs.open sql,conn,1,3
  rs.close
  set rs=nothing
  errmsg="订单项信息修改成功！"
	return_url=goto_url&"?order_no="&order_no&"&item_id="&item_id&"&serial_no="&serial_no
	time_out=0
end if
'response.write return_url
'response.end
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
  			<td class="table_title">修改结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>