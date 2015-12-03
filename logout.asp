<%
session("username")=""
session("userdepart")=""
session("userlev")=""
session.abandon()
time_out=0
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=index.asp'>
    <link href="css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">安全退出</td>
  		</tr>
  		<tr>
  			<td align="center">用户已经安全退出！</td>
  		</tr>
  	</table>
  </body>
</html>
