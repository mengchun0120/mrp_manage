<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
'notify_no=trim(request("notify_no"))
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from notify_info where state='录入' order by date_created desc"
rs.open sql,conn,1,1
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="6">请选择要删除的无效生产通知单号：</td>
  </tr>
  <tr>
    <th>无效生产通知单号</th><th>款号</th><th>制表人</th><th>创建日期</th><th>状态</th><th>操作</th>
  </tr>
  <%while not rs.eof%>
  <form action="del_useless_notify.asp" method=post target="mainFrame">
  <input type=hidden name="notify_no" value="<%=rs("notify_no")%>">
  <tr>
    <td align=center><%=rs("notify_no")%></td><td align=center><%=rs("design_no")%></td><td align=center><%=rs("lister")%></td><td align=center><%=rs("date_created")%></td><td align=center><%=rs("state")%></td>
    <td align=center>
    <%if rs("lister")=session("username") then%>
    	<input type="submit" value="删 除">
    <%else%>
      禁止操作！
    <%end if%>
    </td>
  </tr>
  </form>
  <%  rs.movenext
    wend
    rs.close
    set rs=nothing
  %>
</table>
<br>
<center>
<input name="input_order" type="button" onclick="MM_goToURL('self','del_useless_notify.asp');return document.MM_returnValue" value="全部删除">
</center>
<br>
</body>
</html>