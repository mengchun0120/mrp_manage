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
  	<td class="table_title" colspan="2">�޸�ϵͳ����Ա����</td>
  </tr>
  <tr>
  	<th width="30%">�� �� ����</th>
    <td width="70%"><%=session("username")%></td>
  </tr>
  <tr>
    <th>ԭ �� �룺</th>
    <td><input type="password" name="userpwd_old" maxlength="25"></td>
  </tr>
  <tr>
    <th>�� �� �룺</th>
    <td><input type="password" name="userpwd_new" maxlength="25"> ������25�֣�</td>
  </tr>
  <tr>
    <th>ȷ�����룺</th>
    <td><input type="password" name="userpwd_conform" maxlength="25"> ������25�֣�</td>
  </tr>
  <tr>
    <th>���ڲ��ţ�</th>
    <td><%=session("userdepart")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;��</th>
    <td><%=session("userlev")%></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
</div>
</body>
</html>