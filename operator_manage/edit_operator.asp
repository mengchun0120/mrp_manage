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
if session("userlev")="ϵͳ����Ա" then
	sql2="select * from user_info where userdepart<>'ϵͳ����' order by userdepart"
else
	sql2="select * from user_info where userdepart='"&session("userdepart")&"' and userdepart<>'ϵͳ����' order by userlev"
end if
rs2.open sql2,conn,1,1
serial_no=0
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=5>�޸�ϵͳ����Ա��Ϣ</td>
  </tr>
  <tr>
    <th>���</th>
    <th>�û���</th>
    <th>���ڲ���</th>
    <th>����</th>
    <th>�༭</th>
  </tr>
<%
while not rs2.eof
  serial_no=serial_no+1
%>
<form action="modify_operator.asp" method=post target="mainFrame">
  <input type="hidden" name="username_old" value="<%=rs2("username")%>">
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><input type="text" name="username" value="<%=rs2("username")%>" maxlength="25" size="25">������25�֣�</td>
    <td align="center">
    <%if session("userlev")="ϵͳ����Ա" then%>
    <select name="userdepart" style="width:152px">
      <option value="��Ӫ��" <%if rs2("userdepart")="��Ӫ��" then%>selected<%end if%>>��Ӫ��</option>
      <option value="������" <%if rs2("userdepart")="������" then%>selected<%end if%>>������</option>
      <option value="�ⷿ" <%if rs2("userdepart")="�ⷿ" then%>selected<%end if%>>�ⷿ</option>
    </select>
    <%else%>
    <input type="hidden" name="userdepart" value="<%=rs2("userdepart")%>">
    <%=session("userdepart")%>
    <%end if%>
    </td>
    <td align="center">
    <%if session("userlev")="ϵͳ����Ա" then%>
    <select name="userlev" style="width:152px">
      <option value="���ž���" <%if rs2("userlev")="���ž���" then%>selected<%end if%>>���ž���</option>
      <option value="¼��Ա" <%if rs2("userlev")="¼��Ա" then%>selected<%end if%>>¼��Ա</option>
    </select>
    <%else%>
    <input type="hidden" name="userlev" value="<%=rs2("userlev")%>"><%=rs2("userlev")%>
    <%end if%>
    </td>
    <th align="center"><input type="submit" value="�� ��">
    <input type="reset" value="�� ԭ">
    <input name="del_operator" type="button" onclick="MM_goToURL('self','is_del_operator.asp?username=<%=rs2("username")%>');return document.MM_returnValue" value="ɾ ��"></th>
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