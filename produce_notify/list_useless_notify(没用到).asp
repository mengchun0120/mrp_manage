<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
'notify_no=trim(request("notify_no"))
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from notify_info where state='¼��' order by date_created desc"
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
  	<td class="table_title" colspan="6">��ѡ��Ҫɾ������Ч����֪ͨ���ţ�</td>
  </tr>
  <tr>
    <th>��Ч����֪ͨ����</th><th>���</th><th>�Ʊ���</th><th>��������</th><th>״̬</th><th>����</th>
  </tr>
  <%while not rs.eof%>
  <form action="del_useless_notify.asp" method=post target="mainFrame">
  <input type=hidden name="notify_no" value="<%=rs("notify_no")%>">
  <tr>
    <td align=center><%=rs("notify_no")%></td><td align=center><%=rs("design_no")%></td><td align=center><%=rs("lister")%></td><td align=center><%=rs("date_created")%></td><td align=center><%=rs("state")%></td>
    <td align=center>
    <%if rs("lister")=session("username") then%>
    	<input type="submit" value="ɾ ��">
    <%else%>
      ��ֹ������
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
<input name="input_order" type="button" onclick="MM_goToURL('self','del_useless_notify.asp');return document.MM_returnValue" value="ȫ��ɾ��">
</center>
<br>
</body>
</html>