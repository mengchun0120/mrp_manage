<!--#include file="../inc/conn.asp"-->
<%
on error resume next

set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from news_info where is_show='yes' and news_time between '"&date()&" 00:00:00' and '"&date()&" 23:59:59' order by news_time desc"
'response.write sql
'response.end
rs.open sql,conn,1,1
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV=REFRESH CONTENT='10; URL=show_news.asp'>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<%
while not rs.eof
  select case rs("news_depart")
  	case "经营部"
  	  show_color="#990000"
  	case "生产部"
  	  show_color="#009900"
  	case "库房"
  	  show_color="#000099"
  	case else
  		show_color="#000000"
  	end select
  response.write " <font color="&show_color&">["&hour(rs("news_time"))&":"&minute(rs("news_time"))&" "&rs("news_depart")&" "&rs("news_who")&"] <b>"&rs("news_content")&"</b></font><br>"
  rs.movenext
wend
rs.close
set rs=nothing
%>
<div align="center">
<form action="show_news.asp" method=post target="newsFrame">
	<input type="submit" value="手动刷新">
</form>
</div><br>
</body>
</html>