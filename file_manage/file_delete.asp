<%if session("userlev")="ϵͳ����Ա" then%>
<%filename=request.form("filename")
  Set ObjFileSys=Server.CreateObject("Scripting.FileSystemObject")
  ObjFileSys.DeleteFile filename
  return_url="showfile.asp"
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
  			<td class="table_title">ɾ�����</td>
  		</tr>
  		<tr>
  			<td align="center">ɾ���ɹ���</td>
  		</tr>
  	</table>
  </body>
</html>
<%
else
	time_out=2
	%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=showfile.asp'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">��ʾ���</td>
  		</tr>
  		<tr>
  			<td align="center">������ϵͳ����Ա����ɾ���ļ���</td>
  		</tr>
  	</table>
  </body>
</html>
<%end if%>