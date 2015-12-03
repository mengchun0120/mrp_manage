<%
time_out=2
if session("username")="" or session("userdepart")="" or session("userlev")="" then
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=../index.asp'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">系统超时</td>
  		</tr>
  		<tr>
  			<td align="center">您在20分钟内没有进行任何操作，用户已被自动注销，请重新登录！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
response.end
end if
%>