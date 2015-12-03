<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request("item_id"))
goto_url=trim(request("goto_url"))
is_del=trim(request("is_del"))

if is_del="取 消" then
	response.redirect goto_url&"?item_id="&item_id
  response.end
end if
set rs=Server.CreateObject("ADODB.Recordset")
sql="select order_no from order_info where item_id='"&item_id&"'"
'response.write sql
rs.open sql,conn,1,1
while not rs.eof
  set rs2=Server.CreateObject("ADODB.Recordset")
  sql2="delete from suborder_info where order_no='"&rs("order_no")&"'"
  'response.write sql2
  rs2.open sql2,conn,1,3
  rs2.close
  set rs2=nothing
  rs.movenext
wend
rs.close
set rs=nothing
set rs3=Server.CreateObject("ADODB.Recordset")
sql3="delete from order_info where item_id='"&item_id&"'"
'response.write sql3
rs3.open sql3,conn,1,3
rs3.close
set rs3=nothing
set rs4=Server.CreateObject("ADODB.Recordset")
sql4="delete from item_info where item_id='"&item_id&"'"
'response.write sql4
rs4.open sql4,conn,1,3
rs4.close
set rs4=nothing
errmsg="该生产项以及所包含的所有订单和订单项信息删除成功！"
return_url="edit_item.asp"
time_out=0
'response.redirect "../errmsg.asp?errmsg="&errmsg&"&return_url="&return_url
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
  			<td class="table_title">删除结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>