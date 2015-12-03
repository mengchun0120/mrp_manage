<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_lev.asp"-->
<!--#include file="../news/inc/insert_news.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
serial_no=trim(request("serial_no"))
goto_url=trim(request.form("goto_url"))
suborder_color=trim(request.form("suborder_color"))
suborder_size=trim(request.form("suborder_size"))
suborder_inlen=trim(request.form("suborder_inlen"))
if suborder_inlen="" then
	suborder_inlen=0
end if
suborder_amount=trim(request.form("suborder_amount"))
add_amount=round(suborder_amount*0.05)
if suborder_color="" or suborder_size="" or suborder_amount="" then
	errmsg="所填写各项均不能为空，请重新填写！"
	return_url=goto_url&"?order_no="&order_no&"&item_id="&item_id&"&serial_no="&serial_no&"&suborder_color="&suborder_color&"&suborder_inlen="&suborder_inlen&"&functionary="&functionary
	time_out=2
	'response.write return_url&"<br>"&item_id&"<br>"&order_no
'response.end
else
	set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select * from suborder_info where order_no='"&order_no&"' and suborder_color='"&suborder_color&"' and suborder_size='"&suborder_size&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  	set rs2=Server.CreateObject("ADODB.Recordset")
    sql2="update suborder_info set suborder_amount=suborder_amount+"&cint(suborder_amount)&" where order_no='"&order_no&"' and suborder_color='"&suborder_color&"' and suborder_size='"&suborder_size&"'"
    rs2.open sql2,conn,1,3
    rs2.close
    set rs2=nothing
    call insert_news("更新订单项（订单“"&order_no&"”，生产项“"&item_id&"”）！","no")
  else
    set rs=Server.CreateObject("ADODB.Recordset")
	  sql="insert into suborder_info (suborder_color,suborder_size,suborder_inlen,suborder_amount,order_no,add_amount) values ('"&suborder_color&"','"&suborder_size&"','"&suborder_inlen&"',"&suborder_amount&",'"&order_no&"',"&add_amount&")"
	  rs.open sql,conn,1,3
	  rs.close
    set rs=nothing
    call insert_news("新增订单项（订单“"&order_no&"”，生产项“"&item_id&"”）！","no")
  end if
  rs3.close
  set rs3=nothing
  errmsg="订单项信息录入成功！"
	return_url=goto_url&"?order_no="&order_no&"&item_id="&item_id&"&serial_no="&serial_no&"&suborder_color="&suborder_color&"&suborder_inlen="&suborder_inlen&"&functionary="&functionary
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
  			<td class="table_title">录入结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>