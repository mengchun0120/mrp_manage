<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

set rs2=Server.CreateObject("ADODB.Recordset")
sql2="delete from arrange_amount_info where arrange_no=(select arrange_no from arrange_info where state='Â¼Èë')"
rs2.open sql2,conn,1,3
rs2.close
set rs2=nothing
set rs3=Server.CreateObject("ADODB.Recordset")
sql3="delete from arrange_group_info where arrange_no=(select arrange_no from arrange_info where state='Â¼Èë')"
rs3.open sql3,conn,1,3
rs3.close
set rs3=nothing
set rs=Server.CreateObject("ADODB.Recordset")
sql="delete from arrange_info where state='Â¼Èë'"
rs.open sql,conn,1,3
rs.close
set rs=nothing
response.redirect "list_notify.asp"
%>