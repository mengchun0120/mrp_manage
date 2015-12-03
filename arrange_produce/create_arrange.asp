<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="../news/inc/insert_news.asp"-->
<%
on error resume next
notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
'response.write notify_no&"|"&design_no
'response.end
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
arrange_no="BT-SC-B-002-"&no_year&no_month&no_day
set rs=Server.CreateObject("ADODB.Recordset")
sql="select top 1 arrange_no from arrange_info where arrange_no like '"&arrange_no&"%' order by arrange_no desc"
rs.open sql,conn,1,1
if rs.eof then
	liushuihao="01"
else
	liushuihao=cstr(cint(right(rs("arrange_no"),2))+1)
	if len(liushuihao)=1 then
		liushuihao="0"&liushuihao
	end if
end if
arrange_no=arrange_no&liushuihao
'response.write arrange_no
rs.close
set rs=nothing

set rs2=Server.CreateObject("ADODB.Recordset")
sql2="insert into arrange_info (arrange_no,lister,date_created,state,notify_no,design_no) values ('"&arrange_no&"','"&session("username")&"','"&date_created&"','录入','"&notify_no&"','"&design_no&"')"
rs2.open sql2,conn,1,3
rs2.close
set rs2=nothing
call insert_news("录入排产表“"&arrange_no&"”！","yes")
errmsg="排产表自动生成："&arrange_no
time_out=0
return_url="list_group.asp?arrange_no="&arrange_no&"&design_no="&design_no&"&notify_no="&notify_no
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