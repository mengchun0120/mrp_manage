<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
worker_name_old=trim(request.form("worker_name_old"))
worker_name=trim(request.form("worker_name"))
group_id=trim(request.form("group_id"))

if worker_name="" then
	errmsg="员工姓名不能为空，请重新填写！"
	return_url="edit_worker.asp"
	time_out=1
else
	set rs=Server.CreateObject("ADODB.Recordset")
	sql="select * from worker_info where worker_name='"&worker_name&"' and worker_name<>'"&worker_name_old&"'"
	rs.open sql,conn,1,1
	if not rs.eof then
		errmsg="该员工姓名已经存在，请更换其他的姓名！"
		return_url="edit_worker.asp"
		time_out=2
	else
  	  	set rs2=Server.CreateObject("ADODB.Recordset")
	  	sql2="update worker_info set worker_name='"&worker_name&"',group_id='"&group_id&"' where worker_name='"&worker_name_old&"'"
	  	rs2.open sql2,conn,1,3
	 	rs2.close
    		set rs2=nothing
  		errmsg=worker_name&"的信息修改成功！"
		return_url="edit_worker.asp"
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
  			<td class="table_title">修改结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>