<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request("item_id"))
order_no=trim(request("order_no"))
if item_id<>"" then
	set rs=Server.CreateObject("ADODB.Recordset")
  sql="select functionary from item_info where item_id='"&item_id&"'"
  rs.open sql,conn,1,1
  'response.write item_id&"|||"&rs("functionary")
  'response.write "edit_item.asp?item_id="&item_id&"&functionary="&rs("functionary")
'response.end
  response.redirect "edit_item.asp?item_id="&item_id&"&functionary="&rs("functionary")
end if
%>