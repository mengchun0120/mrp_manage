<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from group_info order by group_id"
rs.open sql,conn,1,1
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<br><br><br><br><br>
<div align=center>
<form action="add_worker.asp" method=post target="mainFrame">
<table width="50%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">¼������С��Ա����Ϣ</td>
  </tr>
  <tr>
    <th width="30%">Ա��������</th>
    <td width="70%"><input type="text" name="worker_name" maxlength="25"> ������25�֣�</td>
  </tr>
  <tr>
    <th width="30%">����С�飺</th>
    <td width="70%">
    <select name="group_id" style="width:152px">
<%while not rs.eof%>
      <option value="<%=rs("group_id")%>" selected><%=rs("group_name")%></option>
<%
  rs.movenext
wend
rs.close
set rs=nothing
%>
    </select>
    </td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
</div>
</body>
</html>