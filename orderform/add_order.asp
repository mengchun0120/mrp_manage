<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_lev.asp"-->
<!--#include file="../news/inc/insert_news.asp"-->
<%
on error resume next
goto_url=trim(request.form("goto_url"))
item_id=trim(request.form("item_id"))
order_no=trim(request.form("order_no"))
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
date_created=now()
'response.write date_created
'response.end
lister=trim(session("username"))

if ult_dest="" then ult_dest=" " end if
if br_pl="" then br_pl=" " end if
if area="" then area=" " end if
if chest_no="" then chest_no=" " end if
if destination="" then destination=" " end if
if material_date="" then material_date=" " end if
if special_client="" then special_client=" " end if
if remark="" then remark=" " end if

if order_no="" or ult_dest="" or br_pl="" or area="" or chest_no="" or destination="" or material_date="" or checkup_date="" or deliver_date="" or special_client="" or remark="" then
	errmsg="“点单号”、“验货日期”和“交货日期”均不能为空，请重新填写！"
	return_url=goto_url&"?item_id="&item_id&"&functionary="&functionary&"&order_no="&order_no&"&ult_dest="&ult_dest&"&br_pl="&br_pl&"&area="&area&"&chest_no="&chest_no&"&destination="&destination&"&material_date="&material_date&"&checkup_date="&checkup_date&"&deliver_date="&deliver_date&"&special_client="&special_client&"&remark="&remark
	time_out=2
elseif isdate(checkup_date)=0 or isdate(deliver_date)=0 or (isdate(material_date)=0 and trim(material_date)<>"") then
	errmsg="所填写的日期无效，请重新填写！"
	return_url=goto_url&"?item_id="&item_id&"&functionary="&functionary&"&order_no="&order_no&"&ult_dest="&ult_dest&"&br_pl="&br_pl&"&area="&area&"&chest_no="&chest_no&"&destination="&destination&"&material_date="&material_date&"&checkup_date="&checkup_date&"&deliver_date="&deliver_date&"&special_client="&special_client&"&remark="&remark
	time_out=1
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from order_info where order_no='"&order_no&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="订单号重复，请重新填写订单号！"
	  return_url=goto_url&"?item_id="&item_id&"&functionary="&functionary&"&order_no="&order_no&"&ult_dest="&ult_dest&"&br_pl="&br_pl&"&area="&area&"&chest_no="&chest_no&"&destination="&destination&"&material_date="&material_date&"&checkup_date="&checkup_date&"&deliver_date="&deliver_date&"&special_client="&special_client&"&remark="&remark
	  time_out=2
  else
  	set rs2=Server.CreateObject("ADODB.Recordset")
	  sql2="insert into order_info (order_no,ult_dest,br_pl,area,chest_no,destination,special_client,remark,date_created,lister,state,item_id,checkup_date,deliver_date,material_date) values ('"&order_no&"','"&ult_dest&"','"&br_pl&"','"&area&"','"&chest_no&"','"&destination&"','"&special_client&"','"&remark&"','"&date_created&"','"&lister&"','录入','"&item_id&"','"&checkup_date&"','"&deliver_date&"','"&material_date&"')"
	  'response.write sql2
	  rs2.open sql2,conn,1,3
	  rs2.close
    set rs2=nothing
  	errmsg="订单基本信息录入成功！"
  	call insert_news("新增订单“"&order_no&"”（生产项“"&item_id&"”）！","yes")
		return_url=goto_url&"?item_id="&item_id&"&functionary="&functionary
		time_out=0
	end if
	rs.close
  set rs=nothing
end if
'response.write errmsg&"|||"&add_rate
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