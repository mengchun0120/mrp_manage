<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
arrange_no=trim(request("arrange_no"))
arrange_group=trim(request("arrange_group"))
date_finish=trim(request("date_finish"))
is_del=trim(request("is_del"))

if is_del="ȡ ��" then
  response.redirect "edit_arrange.asp"
  response.end
end if
if date_finish="" then
	errmsg="���������ڡ�����Ϊ�գ���������д��" 
	time_out=1
	return_url="input_date_finish.asp?arrange_no="&arrange_no&"&arrange_group="&arrange_group
elseif isdate(date_finish)=0 then
	errmsg="����д��������Ч����������д��"
	time_out=1
	return_url="input_date_finish.asp?arrange_no="&arrange_no&"&arrange_group="&arrange_group
else
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="update arrange_group_info set date_finish='"&date_finish&"' where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
  rs.open sql,conn,1,3
  rs.close
  set rs=nothing
  errmsg="����С�顰"&arrange_group&"�����Ų���"&arrange_no&"�����������ڸ�Ϊ��"&date_finish&"����"
  time_out=0
  return_url="edit_arrange.asp"
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
  			<td class="table_title">�������</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>