<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<html>
<head>
  <link href="../css/global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=0 leftmargin=0>
<table width=100%>
<th>小组名称</th>
<th>人数</th>
<th>生产能力</th>
<%
set g=conn.execute("select * from group_info")
while not g.eof
%>
<tr>
<td><%=g("group_name")%></td>
<td><%=g("number")%></td>
<td><%=g("throuphput")%></td>
</tr>
<%
g.movenext
wend
%>
</table>
</body>
</html>