<%
time_out=2
if session("userdepart")<>"������" then
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
  			<td class="table_title">ԽȨ����</td>
  		</tr>
  		<tr>
  			<td align="center">�����ǡ����������ĳ�Ա��û��Ȩ�޽��иò�����</td>
  		</tr>
  	</table>
  </body>
</html>
<%
response.end
end if
%>