<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_user.asp"-->
<%
'����7�����ݾ����ڻ��Թ���
client_name=trim(request("client_name"))
design_no=trim(request("design_no"))
product_name=trim(request("product_name"))
affix_date=trim(request("affix_date"))
man_hour=trim(request("man_hour"))
description=trim(request("description"))
remark=trim(request("remark"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<form action="add_item.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">¼�������������Ϣ</td>
  </tr>
  <tr>
  	<th width="15%">�ͻ����ƣ�</th>
    <td width="35%"><input type="text" name="client_name" maxlength="25" value="<%=client_name%>"> ������25�֣�</td>
    <th width="15%">�� �� Ա��</th>
    <td width="35%"><%=session("username")%><!--<input type="text" name="functionary" maxlength="5"> ������5�֣�--></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td><input type="text" name="design_no" maxlength="25" value="<%=design_no%>"> ������25�֣�</td>
    <th>��Ʒ���ƣ�</th>
    <td><input type="text" name="product_name" maxlength="50" value="<%=product_name%>"> ������50�֣�</td>
  </tr>
  <tr>
    <th>ǩ�����ڣ�</th>
    <td><input type="text" name="affix_date" maxlength="10" <%if affix_date="" then %>value="<%=datevalue(now())%>"<% else %> value="<%=affix_date%>"<%end if%>> ����ʽ��YYYY-MM-DD��</td>
    <th>�� &nbsp;&nbsp;&nbsp;ʱ��</th>
    <td><input type="text" name="man_hour" maxlength="10" value="<%=man_hour%>"> �루��ʽ�����֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td colspan=3><input type="text" name="description" size=80 maxlength="100" value="<%=description%>">  ������100�֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=remark%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
</body>
</html>