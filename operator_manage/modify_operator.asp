<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
on error resume next
username_old=trim(request.form("username_old"))
username=trim(request.form("username"))
userdepart=trim(request.form("userdepart"))
userlev=trim(request.form("userlev"))

if username="" then
	errmsg="����д���������Ϊ�գ���������д��"
	return_url="edit_operator.asp"
	time_out=2
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from user_info where username='"&username&"' and username<>'"&username_old&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="���û����ظ���������������û�����"
		return_url="edit_operator.asp"
		time_out=2
	else
  	  	set rs2=Server.CreateObject("ADODB.Recordset")
	  	sql2="update user_info set username='"&username&"',userdepart='"&userdepart&"',userlev='"&userlev&"' where username='"&username_old&"'"
	  	rs2.open sql2,conn,1,3
	 	rs2.close
    		set rs2=nothing
  		errmsg=username&"����Ϣ�޸ĳɹ���"
		return_url="edit_operator.asp"
		time_out=0
	end if
	rs.close
  	set rs=nothing
end if
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
  			<td class="table_title">�޸Ľ��</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>