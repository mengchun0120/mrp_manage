<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_lev.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<br><br><br><br><br>
<div align=center>
<form action="add_operator.asp" method=post target="mainFrame">
<table width="50%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">录入系统操作员信息</td>
  </tr>
  <tr>
  	<th width="30%">用 户 名：</th>
    <td width="70%"><input type="text" name="username" maxlength="25"> （少于25字）</td>
  </tr>
  <tr>
    <th>密 &nbsp;&nbsp;&nbsp;码：</th>
    <td><input type="text" name="userpwd" maxlength="25"> （少于25字）</td>
  </tr>
  <tr>
    <th>所在部门：</th>
    <td>
    <%if session("userlev")="系统管理员" then%>
    <select name="userdepart" style="width:152px">
      <option value="经营部" selected>经营部</option>
      <option value="生产部" selected>生产部</option>
      <option value="库房" selected>库房</option>
    </select>
    <%else%>
    <input type="hidden" name="userdepart" value="<%=session("userdepart")%>">
    <%=session("userdepart")%>
    <%end if%>
    </td>
  </tr>
  <tr>
    <th>级 &nbsp;&nbsp;&nbsp;别：</th>
    <td>
    <%if session("userlev")="系统管理员" then%>
    <select name="userlev" style="width:152px">
      <option value="部门经理" selected>部门经理</option>
      <option value="录入员" selected>录入员</option>
    </select>
    <%else%>
    <input type="hidden" name="userlev" value="录入员">录入员
    <%end if%>
    </td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="提 交"> <input type="reset" value="重 置"></th>
  </tr>
</table>
</form>
</div>
</body>
</html>