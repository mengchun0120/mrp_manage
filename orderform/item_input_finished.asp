<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="../news/inc/insert_news.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
goto_url=trim(request("goto_url"))
is_del=trim(request("is_del"))

if is_del="ȡ ��" then
  response.redirect goto_url&"?item_id="&item_id&"&order_no="&order_no
  response.end
end if

set rs=Server.CreateObject("ADODB.Recordset")
sql="update item_info set state='¼�����' where item_id='"&item_id&"'"
rs.open sql,conn,1,3
rs.close
set rs=nothing

set rs2=Server.CreateObject("ADODB.Recordset")
sql2="update order_info set state='¼�����' where item_id='"&item_id&"'"
rs2.open sql2,conn,1,3
rs2.close
set rs2=nothing

call insert_news("�����"&item_id&"��¼����ϣ�","yes")
errmsg="��������¼����ϣ�"
time_out=0
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
  			<td class="table_title">�޸Ľ��</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>