<%
Randomize
EmpRnd = int(7999*rnd+2000)		'产生数字附加码
%>
<html>
<head>
<title>中纺宝特服装有限公司MRPII生产管理系统 </title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/oa01.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor=#999999>
<br><br><br><br><br><br><br><br><br><br><br>
<table width="400" height="300" border="0" align="center" cellpadding="0" cellspacing="0" background="img/login.gif">
  <form action=login.asp method=post name=form1 target="_top">
    <tr>
      <td><br><br><br><br>
      	<table width="300" border="0" align="center" cellpadding="0" cellspacing="10">
      		<TR>
      			<TD align="right">用户名：</TD><TD align="left"><input type="text" name="username" size="20"></TD>
      		</TR>
      		<TR>
      			<TD align="right">密码：</TD><TD align="left"><input type="password" name="userpwd" size="20"></TD>
      		</TR>
      		<TR>
      			<TD align="center" colspan=2><input type="submit" name="submit" value="登 录"> <input type="reset" name="reset" value="重 置"></TD>
      		</TR>
      	</table>
      </td>
    </tr>
  </form>
</table>
</body>
</html>