<!--#include file="../inc/user_timeout.asp"-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<br><br><br><br><br>
<div align=center>
<form action="modify_pwd.asp" method=post target="mainFrame">
<table width="50%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">修改系统操作员密码</td>
  </tr>
  <tr>
  	<th width="30%">用 户 名：</th>
    <td width="70%"><%=session("username")%></td>
  </tr>
  <tr>
    <th>原 密 码：</th>
    <td><input type="password" name="userpwd_old" maxlength="25"></td>
  </tr>
  <tr>
    <th>新 密 码：</th>
    <td><input type="password" name="userpwd_new" maxlength="25"> （少于25字）</td>
  </tr>
  <tr>
    <th>确认密码：</th>
    <td><input type="password" name="userpwd_conform" maxlength="25"> （少于25字）</td>
  </tr>
  <tr>
    <th>所在部门：</th>
    <td><%=session("userdepart")%></td>
  </tr>
  <tr>
    <th>级 &nbsp;&nbsp;&nbsp;别：</th>
    <td><%=session("userlev")%></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="修 改"> <input type="reset" value="重 置"></th>
  </tr>
</table>
</form>
</div>
</body>
</html>