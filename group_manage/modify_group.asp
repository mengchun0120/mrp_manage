<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
group_name_old=trim(request.form("group_name_old"))
group_name=trim(request.form("group_name"))

if group_name="" then
	errmsg="����С�����Ʋ���Ϊ�գ���������д��"
	return_url="edit_group.asp"
	time_out=1
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from group_info where group_name='"&group_name&"' and group_name<>'"&group_name_old&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="������С���Ѿ����ڣ����������������С�����ƣ�"
		return_url="edit_group.asp"
		time_out=2
	else
  	  	set rs2=Server.CreateObject("ADODB.Recordset")
	  	sql2="update group_info set group_name='"&group_name&"' where group_name='"&group_name_old&"'"
	  	rs2.open sql2,conn,1,3
	 	rs2.close
    		set rs2=nothing
  		errmsg=group_name&"����Ϣ�޸ĳɹ���"
		return_url="edit_group.asp"
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