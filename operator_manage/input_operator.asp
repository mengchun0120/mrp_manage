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
  	<td class="table_title" colspan="2">¼��ϵͳ����Ա��Ϣ</td>
  </tr>
  <tr>
  	<th width="30%">�� �� ����</th>
    <td width="70%"><input type="text" name="username" maxlength="25"> ������25�֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;�룺</th>
    <td><input type="text" name="userpwd" maxlength="25"> ������25�֣�</td>
  </tr>
  <tr>
    <th>���ڲ��ţ�</th>
    <td>
    <%if session("userlev")="ϵͳ����Ա" then%>
    <select name="userdepart" style="width:152px">
      <option value="��Ӫ��" selected>��Ӫ��</option>
      <option value="������" selected>������</option>
      <option value="�ⷿ" selected>�ⷿ</option>
    </select>
    <%else%>
    <input type="hidden" name="userdepart" value="<%=session("userdepart")%>">
    <%=session("userdepart")%>
    <%end if%>
    </td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;��</th>
    <td>
    <%if session("userlev")="ϵͳ����Ա" then%>
    <select name="userlev" style="width:152px">
      <option value="���ž���" selected>���ž���</option>
      <option value="¼��Ա" selected>¼��Ա</option>
    </select>
    <%else%>
    <input type="hidden" name="userlev" value="¼��Ա">¼��Ա
    <%end if%>
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