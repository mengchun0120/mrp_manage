<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

group_id=trim(request.form("group_id"))
worker_name=trim(request.form("worker_name"))

if group_id="" or worker_name="" then
	errmsg="Ա����������Ϊ�գ���������д��"
	return_url="input_worker.asp"
	time_out=1
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from worker_info where worker_name='"&worker_name&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="��Ա�������Ѿ����ڣ������������������"
		return_url="input_worker.asp"
		time_out=2
	else
  	  	set rs2=Server.CreateObject("ADODB.Recordset")
	  	sql2="insert into worker_info (worker_name,group_id) values ('"&worker_name&"',"&group_id&")"
	  	rs2.open sql2,conn,1,3
	 	rs2.close
    		set rs2=nothing
  		errmsg=worker_name&"����Ϣ¼��ɹ���"
		return_url="input_worker.asp"
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
  			<td class="table_title">¼����</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>