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
  			<td class="table_title">ϵͳ��ʱ</td>
  		</tr>
  		<tr>
  			<td align="center">����20������û�н����κβ������û��ѱ��Զ�ע���������µ�¼��</td>
  		</tr>
  	</table>
  </body>
</html>
<%
response.end
end if
%>