<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request("item_id"))
design_no=trim(request("design_no"))
notify_no=trim(request("notify_no"))
set rs4=Server.CreateObject("ADODB.Recordset")
if design_no="" then
  sql4="select * from item_info where state='¼�����' order by date_created desc"
else
	sql4="select * from item_info where state='¼�����' and design_no='"&design_no&"' order by date_created desc"
	set rs=Server.CreateObject("ADODB.Recordset")
  sql="update notify_info set design_no='"&design_no&"' where notify_no='"&notify_no&"' and design_no is null"
  rs.open sql,conn,1,3
  rs.close
  set rs=nothing
end if
rs4.open sql4,conn,1,1
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
  	<td class="table_title" colspan="6">��ѡ��Ҫ��ѯ�Ŀ�ţ�</td>
  </tr>
  <tr>
    <th>���</th><th>�ͻ�����</th><th>��Ʒ����</th><th>ǩ������</th><th>����Ա</th><th>����</th>
  </tr>
  <%while not rs4.eof%>
  <form action="show_item.asp" method=get target="mainFrame">
  <input type=hidden name="item_id" value="<%=rs4("item_id")%>">
  <input type=hidden name="notify_no" value="<%=notify_no%>">
  <input type=hidden name="design_no" value="<%=rs4("design_no")%>">
  <tr>
    <td align=center><%=rs4("design_no")%></td><td align=center><%=rs4("client_name")%></td><td align=center><%=rs4("product_name")%></td><td align=center><%=rs4("affix_date")%></td><td align=center><%=rs4("functionary")%></td>
      <td align=center><input type="submit" value="�鿴����">
    </td>
  </tr>
  </form>
  <%
    rs4.movenext
  wend
  rs4.close
  set rs4=nothing
  %>
</table>
<br>
<%
if item_id<>"" then
	response.write item_id
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from item_info where item_id='"&item_id&"'"
response.write sql
rs.open sql,conn,1,1
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4"><%=item_id%></td>
  </tr>
  <tr>
  	<th width="15%">�ͻ����ƣ�</th>
    <td width="35%"><%=rs("client_name")%></td>
    <th width="15%">�� �� Ա��</th>
    <td width="35%"><%=rs("functionary")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td><%=rs("design_no")%></td>
    <th>��Ʒ���ƣ�</th>
    <td><%=rs("product_name")%></td>
  </tr>
  <tr>
    <th>ǩ�����ڣ�</th>
    <td><%=rs("affix_date")%></td>
    <th>�� &nbsp;&nbsp;&nbsp;ʱ��</th>
    <td><%=rs("man_hour")%> ��</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td colspan=3><%=rs("description")%></td>
  </tr>
</table>

<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from order_info where item_id='"&item_id&"' and state<>'¼��' order by date_created"
rs2.open sql2,conn,1,1
if not rs2.eof then
	serial_no=0
%>
<table width="100%" cellspacing=1>
  <tr>
    <th>���</th>
    <th>������ PO.NO</th>
    <th>ULT.DEST</th>
    <th>BR/PL</th>
    <th>����</th>
    <th>������</th>
    <th>����</th>
    <th>Ŀ�ĵ�</th>
    <th>�������</th>
    <th>��������</th>
    <th>Ԥ�Ƶ�������</th>
    <th>�ر�ͻ�</th>
    <th>����</th>
  </tr>
<%
all_amount=0
while not rs2.eof
  serial_no=serial_no+1
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select sum(suborder_amount) from suborder_info where order_no='"&rs2("order_no")&"'"
  rs3.open sql3,conn,1,1
    amount=rs3(0)
  all_amount=all_amount+cint(amount)
  rs3.close
  set rs3=nothing
%>
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><a href="show_suborder.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>"&design_no=<%=design_no%> title="�鿴 ��<%=rs2("order_no")%>�� ��ϸ��Ϣ"><%=rs2("order_no")%></a></td>
    <td align="center"><%=rs2("ult_dest")%></td>
    <td align="center"><%=rs2("br_pl")%></td>
    <td align="center"><%=rs2("area")%></td>
    <td align="center"><%=rs2("chest_no")%></td>
    <td align="center"><%=amount%></td>
    <td align="center"><%=rs2("destination")%></td>
    <td align="center"><%=rs2("checkup_date")%></td>
    <td align="center"><%=rs2("deliver_date")%></td>
    <td align="center"><%=rs2("material_date")%></td>
    <td align="center"><%=rs2("special_client")%></td>
    <form action="show_suborder.asp" method=post target="mainFrame">
    	<input type="hidden" name="order_no" value="<%=rs2("order_no")%>">
    	<input type="hidden" name="item_id" value="<%=item_id%>">
    	<input type=hidden name="notify_no" value="<%=notify_no%>">
    	<input type=hidden name="design_no" value="<%=design_no%>">
    <th align="center"><input type="submit" value="�鿴��ϸ"></th>
  </form>
  </tr>
<%
	  rs2.movenext
	wend
%>
  <tr>
    <th>�� &nbsp;ע��</th>
    <td colspan=12><%=trans_code(rs("remark"))%></td>
  </tr>
</table>
<div align=right>�ϼ������� <%=all_amount%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ϼƶ����� <%=serial_no%> �� &nbsp;&nbsp;</div>
<%
end if
rs.close
set rs=nothing
rs2.close
set rs2=nothing
%>
<%end if%>
</body>
</html>