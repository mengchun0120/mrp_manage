<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request.form("item_id"))
order_no=trim(request.form("order_no"))
serial_no=trim(request("serial_no"))
ult_dest=trim(request.form("ult_dest"))
br_pl=trim(request.form("br_pl"))
area=trim(request.form("area"))
chest_no=trim(request.form("chest_no"))
destination=trim(request.form("destination"))
material_date=trim(request.form("material_date"))
checkup_date=trim(request.form("checkup_date"))
deliver_date=trim(request.form("deliver_date"))
special_client=trim(request.form("special_client"))
remark=trim(request.form("remark"))
if order_no="" or ult_dest="" or br_pl="" or area="" or chest_no="" or destination="" or material_date="" or checkup_date="" or deliver_date="" or special_client="" or remark="" then
	errmsg="所填写各项均不能为空，请重新填写！"
	return_url="edit_order.asp?item_id="&item_id&"&order_no="&order_no&"&serial_no="&serial_no
	time_out=2
elseif isdate(checkup_date)=0 or isdate(deliver_date)=0 or isdate(material_date)=0 then
	errmsg="所填写的日期无效，请重新填写！"
	return_url="edit_order.asp?item_id="&item_id&"&order_no="&order_no&"&serial_no="&serial_no
	time_out=1
else
	set rs=Server.CreateObject("ADODB.Recordset")
  sql="update order_info set ult_dest='"&ult_dest&"',br_pl='"&br_pl&"',area='"&area&"',chest_no='"&chest_no&"',destination='"&destination&"',material_date='"&material_date&"',checkup_date='"&checkup_date&"',deliver_date='"&deliver_date&"',special_client='"&special_client&"',remark='"&remark&"',last_modify='"&now()&"' where order_no='"&order_no&"'"
  'response.write sql
  'response.end
  rs.open sql,conn,1,3
  rs.close
  set rs=nothing
  errmsg="订单基本信息修改成功！"
	return_url="edit_order.asp?order_no="&order_no&"&serial_no="&serial_no
	time_out=0
end if
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