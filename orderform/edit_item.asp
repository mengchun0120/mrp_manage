<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request("item_id"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<%
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from item_info where item_id='"&item_id&"'"
'response.write sql
rs.open sql,conn,1,1
%>
<%if rs("state")="¼��" then%>
<form action="modify_item.asp" method=post target="mainFrame">
	<input type="hidden" name="item_id" value="<%=item_id%>">
	<input type="hidden" name="functionary" value="<%=functionary%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">�޸������<%=item_id%>���Ļ�����Ϣ</td>
  </tr>
  <tr>
  	<th width="15%">�ͻ����ƣ�</th>
    <td width="35%"><input type="text" name="client_name" maxlength="25" value="<%=rs("client_name")%>"> ������25�֣�</td>
    <th width="15%">�� �� Ա��</th>
    <td width="35%"><%=rs("functionary")%><!--<input type="text" name="functionary" maxlength="5" value="<%=rs("functionary")%>">--></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td><%=rs("design_no")%> ����ֹ�޸ģ���</td>
    <th>��Ʒ���ƣ�</th>
    <td><input type="text" name="product_name" maxlength="50" value="<%=rs("product_name")%>"> ������50�֣�</td>
  </tr>
  <tr>
  	<th>ǩ�����ڣ�</th>
    <td><input type="text" name="affix_date" maxlength="10" value="<%=rs("affix_date")%>"> ����ʽ��YYYY-MM-DD��</td>
    <th>�� &nbsp;&nbsp;&nbsp;ʱ��</th>
    <td><input type="text" name="man_hour" maxlength="10" value="<%=rs("man_hour")%>"> �루��ʽ�����֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td colspan=3><input type="text" name="description" size=80 maxlength="100" value="<%=rs("description")%>">  ������100�֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=rs("remark")%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ԭ"> <input name="del_item" type="button" onclick="MM_goToURL('self','is_del_item.asp?item_id=<%=item_id%>&goto_url=edit_item.asp');return document.MM_returnValue" value="ɾ ��"> <input name="edit_item" type="button" onclick="MM_goToURL('self','list_item.asp');return document.MM_returnValue" value="�� ��"></th>
  </tr>
</table>
</form>
<%else%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">�����<%=item_id%>���Ļ�����Ϣ</td>
  </tr>
  <tr>
  	<th width="15%">�ͻ����ƣ�</th>
    <td width="35%"><%=rs("client_name")%></td>
    <th width="15%">�� �� Ա��</th>
    <td width="35%"><%=rs("functionary")%><!--<input type="text" name="functionary" maxlength="5" value="<%=rs("functionary")%>">--></td>
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
    <td><%=rs("man_hour")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td colspan=3><%=rs("description")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><%=trans_code(rs("remark"))%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input name="edit_item" type="button" onclick="MM_goToURL('self','list_item.asp');return document.MM_returnValue" value="�� ��"></th>
  </tr>
</table><br>
<%end if%>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from order_info where item_id='"&item_id&"' order by date_created"
rs2.open sql2,conn,1,1
if not rs2.eof then
	serial_no=0
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="14">��¼����������Ϣ</td>
  </tr>
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
    <th colspan=2>����</th>
  </tr>
<%
while not rs2.eof
  serial_no=serial_no+1
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select sum(suborder_amount) from suborder_info where order_no='"&rs2("order_no")&"'"
  rs3.open sql3,conn,1,1
  amount=rs3(0)
  rs3.close
  set rs3=nothing
%>
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><a href="edit_order.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>" title="�༭���� ��<%=rs2("order_no")%>�� "><%=rs2("order_no")%></a></td>
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
    <form action="edit_order.asp" method=post target="mainFrame">
    	<input type="hidden" name="order_no" value="<%=rs2("order_no")%>">
    	<input type="hidden" name="serial_no" value="<%=serial_no%>">
    <th align="center"><input type="submit" value="�� ��">
    	<%if rs("state")="¼��" then%>
    	  <input name="del_order" type="button" onclick="MM_goToURL('self','is_del_order.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>&goto_url=edit_item.asp');return document.MM_returnValue" value="ɾ ��">
    	<%end if%>
    </th></form>
  
  </tr>
<%
	  rs2.movenext
	wend
%>
</table>
<%
end if
rs2.close
set rs2=nothing
%>
<%if rs("state")="¼��" then%>
<form action="add_order.asp" method=post target="mainFrame">
	<input type="hidden" name="item_id" value="<%=item_id%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">���Ӷ���������Ϣ</td>
  </tr>
  <tr>
    <th align=right width="15%">�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td width="35%"><%=serial_no+1%></td>
    <th width="15%">������ PO.NO��</th>
    <td width="35%"><input type="text" name="order_no"> ������25�֣�</td>
  </tr>
  <tr>
  	<th>ULT.DEST��</th>
    <td><input type="text" name="ult_dest"> ������25�֣�</td>
    <th>BR/PL��</th>
    <td><input type="text" name="br_pl"> ������25�֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td><input type="text" name="area"> ������25�֣�</td>
    <th>�����ţ�</th>
    <td><input type="text" name="chest_no"> ������25�֣�</td>
  </tr>
  <tr>
    <th>Ŀ �� �أ�</th>
    <td><input type="text" name="destination"> ������25�֣�</td>
    <th>�ر�ͻ���</th>
    <td><input type="text" name="special_client"> ������25�֣�</td>
  </tr>
  <tr>
  	<th>������ڣ�</th>
    <td><input type="text" name="checkup_date" maxlength="10"> ����ʽ��YYYY-MM-DD��</td>
    <th>�������ڣ�</th>
    <td><input type="text" name="deliver_date" maxlength="10"> ����ʽ��YYYY-MM-DD��</td>
  </tr>
  <tr>
  	<th>Ԥ�Ƶ������ڣ�</th>
    <td colspan=3><input type="text" name="material_date" maxlength="10"> ����ʽ��YYYY-MM-DD��</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4></textarea></td>
  </tr>
  <input type="hidden" name="goto_url" value="edit_item.asp">
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
<%
end if
rs.close
set rs=nothing
%>
</body>
</html>