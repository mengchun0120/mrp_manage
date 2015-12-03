<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_lev.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
if session("userlev")="系统管理员" then
	sql2="select * from user_info where userdepart<>'系统管理部' order by userdepart"
else
	sql2="select * from user_info where userdepart='"&session("userdepart")&"' and userdepart<>'系统管理部' order by userlev"
end if
rs2.open sql2,conn,1,1
serial_no=0
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=5>修改系统操作员信息</td>
  </tr>
  <tr>
    <th>序号</th>
    <th>用户名</th>
    <th>所在部门</th>
    <th>级别</th>
    <th>编辑</th>
  </tr>
<%
while not rs2.eof
  serial_no=serial_no+1
%>
<form action="modify_operator.asp" method=post target="mainFrame">
  <input type="hidden" name="username_old" value="<%=rs2("username")%>">
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><input type="text" name="username" value="<%=rs2("username")%>" maxlength="25" size="25">（少于25字）</td>
    <td align="center">
    <%if session("userlev")="系统管理员" then%>
    <select name="userdepart" style="width:152px">
      <option value="经营部" <%if rs2("userdepart")="经营部" then%>selected<%end if%>>经营部</option>
      <option value="生产部" <%if rs2("userdepart")="生产部" then%>selected<%end if%>>生产部</option>
      <option value="库房" <%if rs2("userdepart")="库房" then%>selected<%end if%>>库房</option>
    </select>
    <%else%>
    <input type="hidden" name="userdepart" value="<%=rs2("userdepart")%>">
    <%=session("userdepart")%>
    <%end if%>
    </td>
    <td align="center">
    <%if session("userlev")="系统管理员" then%>
    <select name="userlev" style="width:152px">
      <option value="部门经理" <%if rs2("userlev")="部门经理" then%>selected<%end if%>>部门经理</option>
      <option value="录入员" <%if rs2("userlev")="录入员" then%>selected<%end if%>>录入员</option>
    </select>
    <%else%>
    <input type="hidden" name="userlev" value="<%=rs2("userlev")%>"><%=rs2("userlev")%>
    <%end if%>
    </td>
    <th align="center"><input type="submit" value="修 改">
    <input type="reset" value="还 原">
    <input name="del_operator" type="button" onclick="MM_goToURL('self','is_del_operator.asp?username=<%=rs2("username")%>');return document.MM_returnValue" value="删 除"></th>
</form>
  </tr>
<%
  rs2.movenext
wend
%>
</table>
<%
rs2.close
set rs2=nothing
%>
</body>
</html>