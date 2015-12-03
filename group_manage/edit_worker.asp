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
while not rs.eof
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=5>生产小组“<%=rs("group_name")%>”员工信息</td>
  </tr>
  <tr>
    <th>序号</th>
    <th>员工姓名</th>
    <th>所在小组</th>
    <th>编辑</th>
  </tr>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from worker_info where group_id="&rs("group_id")
rs2.open sql2,conn,1,1
serial_no=0
while not rs2.eof
  serial_no=serial_no+1
%>
<form action="modify_worker.asp" method=post target="mainFrame">
  <input type="hidden" name="worker_name_old" value="<%=rs2("worker_name")%>">
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><input type="text" name="worker_name" value="<%=rs2("worker_name")%>" maxlength="25" size="25">（少于25字）</td>
    <td align="center">
    <select name="group_id" style="width:152px">
<%
set rs3=Server.CreateObject("ADODB.Recordset")
sql3="select * from group_info order by group_id"
rs3.open sql3,conn,1,1
while not rs3.eof
%>
      <option value="<%=rs3("group_id")%>" <%if rs2("group_id")=rs3("group_id") then%>selected<%end if%>><%=rs3("group_name")%></option>
<%
  rs3.movenext
wend
rs3.close
set rs3=nothing
%>
    </select>
    </td>
    <th align="center"><input type="submit" value="修 改">
    <input type="reset" value="还 原">
    <input name="del_worker" type="button" onclick="MM_goToURL('self','is_del_worker.asp?worker_name=<%=rs2("worker_name")%>');return document.MM_returnValue" value="删 除"></th>
</form>
  </tr>
<%
  rs2.movenext
wend
rs2.close
set rs2=nothing
%>
</table>
<%
  rs.movenext
wend
rs.close
set rs=nothing
%>
</div>
</body>
</html>