<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<div align=center>
<%
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from group_info order by group_id"
rs.open sql,conn,1,1
serial_no=0
%>
<table width="60%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=5>�޸�����С����Ϣ</td>
  </tr>
  <tr>
    <th>���</th>
    <th>С������</th>
    <th>�༭</th>
  </tr>
<%
while not rs.eof
  serial_no=serial_no+1
%>
<form action="modify_group.asp" method=post target="mainFrame">
  <input type="hidden" name="group_name_old" value="<%=rs("group_name")%>">
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><input type="text" name="group_name" value="<%=rs("group_name")%>" maxlength="25" size="25">������25�֣�</td>
    <th align="center"><input type="submit" value="�� ��">
    <input type="reset" value="�� ԭ">
    <input name="del_group" type="button" onclick="MM_goToURL('self','is_del_group.asp?group_name=<%=rs("group_name")%>');return document.MM_returnValue" value="ɾ ��"></th>
</form>
  </tr>
<%
  rs.movenext
wend
%>
</table>
<%
rs.close
set rs=nothing
%>
</div>
</body>
</html>