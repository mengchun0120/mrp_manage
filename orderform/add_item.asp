<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="../news/inc/insert_news.asp"-->
<%
on error resume next

client_name=trim(request.form("client_name"))
functionary=trim(session("username"))
design_no=trim(request.form("design_no"))
product_name=trim(request.form("product_name"))
'deliver_date=trim(request.form("deliver_date"))
affix_date=trim(request.form("affix_date"))
man_hour=trim(request.form("man_hour"))
'getmaterial_date=trim(request.form("getmaterial_date"))
description=trim(request.form("description"))
remark=trim(request.form("remark"))
if description="" then
	description=" "
end if
if remark="" then
	remark=" "
end if
date_created=now()
'lister=trim(session("user"))
'lister="user_guest"
item_id=design_no&"/"&datevalue(date_created)

if client_name="" or functionary="" or design_no="" or product_name="" or affix_date="" or man_hour="" or description="" or remark="" then
	errmsg="所填写各项均不能为空，请重新填写！"
	return_url="input_item.asp?client_name="&client_name&"&design_no="&design_no&"&product_name="&product_name&"&affix_date="&affix_date&"&man_hour="&man_hour&"&description="&description&"&remark="&remark
	time_out=2
elseif isdate(affix_date)=0 then
	errmsg="所填写的日期无效，请重新填写！"
	return_url="input_item.asp?client_name="&client_name&"&design_no="&design_no&"&product_name="&product_name&"&affix_date="&affix_date&"&man_hour="&man_hour&"&description="&description&"&remark="&remark
	time_out=1
elseif isnumeric(man_hour)=false then
	errmsg="所填写的工时只能是阿拉伯数字，请重新填写！"
	return_url="input_item.asp?client_name="&client_name&"&design_no="&design_no&"&product_name="&product_name&"&affix_date="&affix_date&"&man_hour="&man_hour&"&description="&description&"&remark="&remark
	time_out=2
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from item_info where item_id='"&item_id&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="该款号重复，请重新填写款号！"
	  return_url="input_item.asp?client_name="&client_name&"&design_no="&design_no&"&product_name="&product_name&"&affix_date="&affix_date&"&man_hour="&man_hour&"&description="&description&"&remark="&remark
	  time_out=1
  else
  	set rs2=Server.CreateObject("ADODB.Recordset")
	  sql2="insert into item_info (item_id,client_name,functionary,design_no,product_name,affix_date,man_hour,description,remark,date_created,state) values ('"&item_id&"','"&client_name&"','"&functionary&"','"&design_no&"','"&product_name&"','"&affix_date&"',"&man_hour&",'"&description&"','"&remark&"','"&date_created&"','录入')"
	  rs2.open sql2,conn,1,3
	  rs2.close
    set rs2=nothing
  	errmsg="生产项基本信息录入成功！"
  	call insert_news("新增生产项“"&item_id&"”！","yes")
		return_url="input_order.asp?item_id="&item_id&"&functionary="&functionary
		time_out=0
	end if
	rs.close
  set rs=nothing
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
  			<td class="table_title">录入结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>