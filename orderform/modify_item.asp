<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request.form("item_id"))
client_name=trim(request.form("client_name"))
functionary=trim(session("username"))
'design_no=trim(request.form("design_no"))
product_name=trim(request.form("product_name"))
'deliver_date=trim(request.form("deliver_date"))
affix_date=trim(request.form("affix_date"))
man_hour=trim(request.form("man_hour"))
'getmaterial_date=trim(request.form("getmaterial_date"))
description=trim(request.form("description"))
remark=trim(request.form("remark"))

if client_name="" or product_name="" or affix_date="" or man_hour="" or description="" or remark="" then
	errmsg="����д���������Ϊ�գ���������д��"
	return_url="edit_item.asp?item_id="&item_id
	time_out=2
elseif isdate(affix_date)=0 then
	errmsg="����д��������Ч����������д��"
	return_url="edit_item.asp?item_id="&item_id
	time_out=1
elseif isnumeric(man_hour)=false then
	errmsg="����д�Ĺ�ʱֻ���ǰ��������֣���������д��"
	return_url="edit_item.asp?item_id="&item_id
	time_out=2
else
	set rs=Server.CreateObject("ADODB.Recordset")
  sql="update item_info set client_name='"&client_name&"',product_name='"&product_name&"',affix_date='"&affix_date&"',man_hour='"&man_hour&"',description='"&description&"',remark='"&remark&"',last_modify='"&now()&"' where item_id='"&item_id&"'"
  'response.write sql
  'response.end
  rs.open sql,conn,1,3
  rs.close
  set rs=nothing
  errmsg="�����������Ϣ�޸ĳɹ���"
	return_url="edit_item.asp?item_id="&item_id
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
  			<td class="table_title">�޸Ľ��</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>