<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<html>
<head>
  <link href="../css/global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=0 leftmargin=0>
<table width=100%>
<th>С������</th>
<th>����</th>
<th>��������</th>
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