<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
on error resume next
'item_id=trim(request("item_id"))
order_no=trim(request("order_no"))
serial_no=trim(request("serial_no"))
suborder_color=trim(request("suborder_color"))
suborder_inlen=trim(request("suborder_inlen"))
if serial_no="" then
	serial_no="���Զ���ţ�"
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>

<%
if order_no<>"" then
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from order_info where order_no='"&order_no&"'"
rs.open sql,conn,1,1
%>
<%if rs("state")="¼��" then%>
<form action="modify_order.asp" method=post target="mainFrame">
	<input type="hidden" name="order_no" value="<%=order_no%>">
  <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
  <input type="hidden" name="serial_no" value="<%=serial_no%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">�޸Ķ�����<%=order_no%>���Ļ�����Ϣ</td>
  </tr>
  <tr>
    <th align=right width="15%">�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td width="35%"><%=serial_no%></td>
    <th width="15%">������ PO.NO��</th>
    <td width="35%"><%=rs("order_no")%> ����ֹ�޸ģ���</td>
  </tr>
  <tr>
  	<th>ULT.DEST��</th>
    <td><input type="text" name="ult_dest" value="<%=rs("ult_dest")%>"> ������25�֣�</td>
    <th>BR/PL��</th>
    <td><input type="text" name="br_pl" value="<%=rs("br_pl")%>"> ������25�֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td><input type="text" name="area" value="<%=rs("area")%>"> ������25�֣�</td>
    <th>�����ţ�</th>
    <td><input type="text" name="chest_no" value="<%=rs("chest_no")%>"> ������25�֣�</td>
  </tr>
  <tr>
    <th>Ŀ �� �أ�</th>
    <td><input type="text" name="destination" value="<%=rs("destination")%>"> ������25�֣�</td>
    <th>�ر�ͻ���</th>
    <td><input type="text" name="special_client" value="<%=rs("special_client")%>"> ������25�֣�</td>
  </tr>
  <tr>
  	<th>������ڣ�</th>
    <td><input type="text" name="checkup_date" maxlength="10" value="<%=rs("checkup_date")%>"> ����ʽ��YYYY-MM-DD��</td>
    <th>�������ڣ�</th>
    <td><input type="text" name="deliver_date" maxlength="10" value="<%=rs("deliver_date")%>"> ����ʽ��YYYY-MM-DD��</td>
  </tr>
  <tr>
  	<th>Ԥ�Ƶ������ڣ�</th>
    <td colspan=3><input type="text" name="material_date" maxlength="10" value="<%=rs("material_date")%>"> ����ʽ��YYYY-MM-DD��</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=rs("remark")%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ԭ">
    	<input name="edit_item" type="button" onclick="MM_goToURL('self','edit_item.asp?item_id=<%=rs("item_id")%>');return document.MM_returnValue" value="�� ��">
    </th>
  </tr>
</table>
</form>
<%else%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">������<%=order_no%>���Ļ�����Ϣ</td>
  </tr>
  <tr>
    <th align=right width="15%">�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td width="35%"><%=serial_no%></td>
    <th width="15%">������ PO.NO��</th>
    <td width="35%"><%=rs("order_no")%></td>
  </tr>
  <tr>
  	<th>ULT.DEST��</th>
    <td><%=rs("ult_dest")%></td>
    <th>BR/PL��</th>
    <td><%=rs("br_pl")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td><%=rs("area")%></td>
    <th>�����ţ�</th>
    <td><%=rs("chest_no")%></td>
  </tr>
  <tr>
    <th>Ŀ �� �أ�</th>
    <td><%=rs("destination")%></td>
    <th>�ر�ͻ���</th>
    <td><%=rs("special_client")%></td>
  </tr>
  <tr>
  	<th>������ڣ�</th>
    <td><%=rs("checkup_date")%></td>
    <th>�������ڣ�</th>
    <td><%=rs("deliver_date")%></td>
  </tr>
  <tr>
  	<th>Ԥ�Ƶ������ڣ�</th>
    <td colspan=3><%=rs("material_date")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><%=trans_code(rs("remark"))%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center">
    	<input name="edit_item" type="button" onclick="MM_goToURL('self','edit_item.asp?item_id=<%=rs("item_id")%>');return document.MM_returnValue" value="�� ��">
    </th>
  </tr>
</table><br>
<%end if%>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from suborder_info where order_no='"&order_no&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
	sub_serial_no=0
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=6>�޸���¼��������Ϣ</td>
  </tr>
  <tr>
    <th>���</th>
    <th>ɫ��</th>
    <th>����</th>
    <th>�ڳ�</th>
    <th>����</th>
    <th>�༭</th>
  </tr>
<%
while not rs2.eof
  sub_serial_no=sub_serial_no+1
%>
<%if rs("state")="¼��" then%>
<form action="modify_suborder.asp" method=post target="mainFrame">
  <tr>
    <th><%=sub_serial_no%></th>
    <input type="hidden" name="suborder_no" value="<%=rs2("suborder_no")%>">
    <input type="hidden" name="order_no" value="<%=order_no%>">
    <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
    <input type="hidden" name="serial_no" value="<%=serial_no%>">
    <input type="hidden" name="goto_url" value="edit_order.asp">
    <td align="center"><input type="text" name="suborder_color" value="<%=rs2("suborder_color")%>" size="20">������25�֣�</td>
    <td align="center"><input type="text" name="suborder_size" value="<%=rs2("suborder_size")%>" size="6">������25�֣�</td>
    <td align="center"><input type="text" name="suborder_inlen" value="<%=rs2("suborder_inlen")%>" size="6">�����֣���Ϊ�գ�</td>
    <td align="center"><input type="text" name="suborder_amount" value="<%=rs2("suborder_amount")%>" size="8">�����֣�</td>
    <th align="center"><input type="submit" value="�� ��">
    <input type="reset" value="�� ԭ">
    <input name="del_suborder" type="button" onclick="MM_goToURL('self','is_del_suborder.asp?suborder_no=<%=rs2("suborder_no")%>&order_no=<%=order_no%>&item_id=<%=rs("item_id")%>&serial_no=<%=serial_no%>&goto_url=edit_order.asp');return document.MM_returnValue" value="ɾ ��"></th>
</form>
<%else%>
<form action="modify_suborder.asp" method=post target="mainFrame">
  <tr>
    <th><%=sub_serial_no%></th>
    <input type="hidden" name="suborder_no" value="<%=rs2("suborder_no")%>">
    <input type="hidden" name="order_no" value="<%=order_no%>">
    <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
    <input type="hidden" name="serial_no" value="<%=serial_no%>">
    <input type="hidden" name="goto_url" value="edit_order.asp">
    <td align="center"><input type="hidden" name="suborder_color" value="<%=rs2("suborder_color")%>" size="20"><%=rs2("suborder_color")%></td>
    <td align="center"><input type="hidden" name="suborder_size" value="<%=rs2("suborder_size")%>" size="6"><%=rs2("suborder_size")%></td>
    <td align="center"><input type="text" name="suborder_inlen" value="<%=rs2("suborder_inlen")%>" size="6">�����֣���Ϊ�գ�</td>
    <td align="center"><input type="text" name="suborder_amount" value="<%=rs2("suborder_amount")%>" size="8">�����֣�</td>
    <th align="center"><input type="submit" value="�� ��">
    <input type="reset" value="�� ԭ">
    </th>
</form>
<%end if%>
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
<br>
<%if rs("state")="¼��" then%>
<form action="add_suborder.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="5">���Ӷ�����</td>
  </tr>
  <tr>
    <th>���</th>
    <th>ɫ��</th>
    <th>����</th>
    <th>�ڳ�</th>
    <th>����</th>
  </tr>
  <tr>
    <th><%=sub_serial_no+1%></th>
    <td align="center"><input type="text" name="suborder_color" size="25" value="<%=suborder_color%>">������25�֣�</td>
    <td align="center"><input type="text" name="suborder_size" size="11">������25�֣�</td>
    <td align="center"><input type="text" name="suborder_inlen" size="11" value="<%=suborder_inlen%>">�����֣���Ϊ�գ�</td>
    <td align="center"><input type="text" name="suborder_amount" size="13">�����֣�</td>
    <input type="hidden" name="order_no" value="<%=order_no%>">
    <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
    <input type="hidden" name="serial_no" value="<%=serial_no%>">
    <input type="hidden" name="goto_url" value="edit_order.asp">
  </tr>
  <tr>
    <th colspan="5" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
<center>
<input name="affirm_order" type="button" onclick="MM_goToURL('self','is_item_input_finished.asp?item_id=<%=rs("item_id")%>&order_no=<%=order_no%>&goto_url=edit_order.asp');return document.MM_returnValue" value="ȷ��¼�����">&nbsp;&nbsp;
<br><br>
</center>
<%end if%>
<%
end if
rs.close
set rs=nothing
%>
</body>
</html>