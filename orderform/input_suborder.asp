<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
'response.write functionary&"|||"&session("username")
on error resume next
item_id=trim(request("item_id"))
order_no=trim(request("order_no"))
suborder_color=trim(request("suborder_color"))
suborder_inlen=trim(request("suborder_inlen"))
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from order_info where order_no='"&order_no&"'"
rs2.open sql2,conn,1,1
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from item_info where item_id='"&rs2("item_id")&"'"
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
  	<td class="table_title" colspan="4">�����<%=rs2("item_id")%>���Լ�������<%=order_no%>���Ļ�����Ϣ</td>
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
    <th>Ԥ�Ƶ������ڣ�</th>
    <td><%=rs2("material_date")%></td>
  </tr>
  <tr>
    <th>������ڣ�</th>
    <td><%=rs2("checkup_date")%></td>
    <th>�������ڣ�</th>
    <td><%=rs2("deliver_date")%></td>
  </tr>
  <tr>
    <th>�� �� �ţ�</th>
    <td><%=rs2("order_no")%></td>
    <th>Ŀ �� �أ�</th>
    <td><%=rs2("destination")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td colspan=3><%=rs("description")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><%=trans_code(rs2("remark"))%></td>
  </tr>
  <th colspan="4" align="center">
    <input name="input_order" type="button" onclick="MM_goToURL('self','input_order.asp?item_id=<%=item_id%>&functionary=<%=functionary%>');return document.MM_returnValue" value="�� ��">
  </th>
</table>
<br>
<%
rs.close
set rs=nothing
rs2.close
set rs2=nothing
set rs3=Server.CreateObject("ADODB.Recordset")
sql3="select * from suborder_info where order_no='"&order_no&"'"
rs3.open sql3,conn,1,1
if not rs3.eof then
	serial_no=0
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="5">��¼��������Ϣ</td>
  </tr>
  <tr>
    <th>���</th>
    <th>ɫ��</th>
    <th>����</th>
    <th>�ڳ�</th>
    <th>����</th>
  </tr>
<%
while not rs3.eof
  serial_no=serial_no+1
%>
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><%=rs3("suborder_color")%></td>
    <td align="center"><%=rs3("suborder_size")%></td>
    <td align="center"><%=rs3("suborder_inlen")%></td>
    <td align="center"><%=rs3("suborder_amount")%></td>
  </tr>
<%
	  rs3.movenext
	wend
%>
</table>
<%
end if
rs3.close
set rs3=nothing
%>
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
    <th><%=serial_no+1%></th>
    <td align="center"><input type="text" name="suborder_color" size="25" value="<%=suborder_color%>">������25�֣�</td>
    <td align="center"><input type="text" name="suborder_size" size="11">������25�֣�</td>
    <td align="center"><input type="text" name="suborder_inlen" size="11" value="<%=suborder_inlen%>">�����֣���Ϊ�գ�</td>
    <td align="center"><input type="text" name="suborder_amount" size="13">�����֣�</td>
    <input type="hidden" name="item_id" value="<%=item_id%>">
    <input type="hidden" name="order_no" value="<%=order_no%>">
    <input type="hidden" name="goto_url" value="input_suborder.asp">
    <input type="hidden" name="functionary" value="<%=functionary%>">
  </tr>
  <tr>
    <th colspan="5" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
<center>
<input name="affirm_order" type="button" onclick="MM_goToURL('self','is_item_input_finished.asp?item_id=<%=item_id%>&order_no=<%=order_no%>&goto_url=input_suborder.asp');return document.MM_returnValue" value="ȷ��¼�����">&nbsp;&nbsp;
<br><br>
</center>
</body>
</html>