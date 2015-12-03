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
  	<td class="table_title" colspan=5>修改生产小组信息</td>
  </tr>
  <tr>
    <th>序号</th>
    <th>小组名称</th>
    <th>编辑</th>
  </tr>
<%
while not rs.eof
  serial_no=serial_no+1
%>
<form action="modify_group.asp" method=post target="mainFrame">
  <input type="hidden" name="group_name_old" value="<%=rs("group_name")%>">
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><input type="text" name="group_name" value="<%=rs("group_name")%>" maxlength="25" size="25">（少于25字）</td>
    <th align="center"><input type="submit" value="修 改">
    <input type="reset" value="还 原">
    <input name="del_group" type="button" onclick="MM_goToURL('self','is_del_group.asp?group_name=<%=rs("group_name")%>');return document.MM_returnValue" value="删 除"></th>
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