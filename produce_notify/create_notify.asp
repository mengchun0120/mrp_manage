<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

date_created=now()
no_year=right(year(date_created),2)
if len(month(date_created))=1 then
	no_month="0"&month(date_created)
else
	no_month=month(date_created)
end if
if len(day(date_created))=1 then
	no_day="0"&day(date_created)
else
	no_day=day(date_created)
end if
notify_no="BT-SC-B-001-"&no_year&no_month&no_day
set rs=Server.CreateObject("ADODB.Recordset")
sql="select top 1 notify_no from notify_info where notify_no like '"&notify_no&"%' order by notify_no desc"
rs.open sql,conn,1,1
if rs.eof then
	liushuihao="01"
else
	liushuihao=cstr(cint(right(rs("notify_no"),2))+1)
	if len(liushuihao)=1 then
		liushuihao="0"&liushuihao
	end if
end if
notify_no=notify_no&liushuihao
'response.write notify_no
rs.close
set rs=nothing

set rs2=Server.CreateObject("ADODB.Recordset")
sql2="insert into notify_info (notify_no,lister,date_created,state) values ('"&notify_no&"','"&session("username")&"','"&date_created&"','录入')"
rs2.open sql2,conn,1,3
rs2.close
set rs2=nothing
errmsg="生产通知单号自动生成："&notify_no
return_url="show_item.asp?notify_no="&notify_no
time_out=0
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