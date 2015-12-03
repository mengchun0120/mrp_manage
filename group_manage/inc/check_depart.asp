<%
time_out=2
if session("userdepart")<>"生产部" then
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=../welcome.asp'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">越权操作</td>
  		</tr>
  		<tr>
  			<td align="center">您不是“生产部”的成员，没有权限进行该操作！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
response.end
end if
%>