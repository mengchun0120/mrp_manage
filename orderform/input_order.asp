<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_lev.asp"-->
<%
on error resume next
item_id=trim(request("item_id"))
'����11�����ݾ����ڻ��Թ���
order_no=trim(request("order_no"))
ult_dest=trim(request("ult_dest"))
br_pl=trim(request("br_pl"))
area=trim(request("area"))
chest_no=trim(request("chest_no"))
destination=trim(request("destination"))
material_date=trim(request("material_date"))
checkup_date=trim(request("checkup_date"))
deliver_date=trim(request("deliver_date"))
special_client=trim(request("special_client"))
remark=trim(request("remark"))

set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from item_info where item_id='"&item_id&"'"
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
  	<td class="table_title" colspan="4">�����<%=item_id%>���Ļ�����Ϣ</td>
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
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><%=trans_code(rs("remark"))%></td>
  </tr>
</table>
<br>
<%
rs.close
set rs=nothing
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from order_info where item_id='"&item_id&"' order by date_created"
rs2.open sql2,conn,1,1
if not rs2.eof then
	serial_no=0
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">��¼����������Ϣ</td>
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
    <th>����</th>
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
    <td align="center"><a href="input_suborder.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>&functionary=<%=functionary%>" title="���� ��<%=rs2("order_no")%>�� �Ķ�����"><%=rs2("order_no")%></a></td>
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
    <form action="input_suborder.asp" method=post target="mainFrame">
    	<input type="hidden" name="order_no" value="<%=rs2("order_no")%>">
    	<input type="hidden" name="item_id" value="<%=item_id%>">
    	<input type="hidden" name="functionary" value="<%=functionary%>">
    <th align="center"><input type="submit" value="���Ӷ�����"></th>
  </form>
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
<form action="add_order.asp" method=post target="mainFrame">
	<input type="hidden" name="item_id" value="<%=item_id%>">
	<input type="hidden" name="functionary" value="<%=functionary%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">���Ӷ���������Ϣ</td>
  </tr>
  <tr>
    <th align=right width="15%">�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td width="35%"><%=serial_no+1%></td>
    <th width="15%">������ PO.NO��</th>
    <td width="35%"><input type="text" name="order_no" value="<%=order_no%>"> ������25�֣�</td>
  </tr>
  <tr>
  	<th>ULT.DEST��</th>
    <td><input type="text" name="ult_dest" value="<%=ult_dest%>"> ������25�֣�</td>
    <th>BR/PL��</th>
    <td><input type="text" name="br_pl" value="<%=br_pl%>"> ������25�֣�</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;����</th>
    <td><input type="text" name="area" value="<%=area%>"> ������25�֣�</td>
    <th>�����ţ�</th>
    <td><input type="text" name="chest_no" value="<%=chest_no%>"> ������25�֣�</td>
  </tr>
  <tr>
    <th>Ŀ �� �أ�</th>
    <td><input type="text" name="destination" value="<%=destination%>"> ������25�֣�</td>
    <th>�ر�ͻ���</th>
    <td><input type="text" name="special_client" value="<%=special_client%>"> ������25�֣�</td>
  </tr>
  <tr>
  	<th>������ڣ�</th>
    <td><input type="text" name="checkup_date" maxlength="10" value="<%=checkup_date%>"> ����ʽ��YYYY-MM-DD��</td>
    <th>�������ڣ�</th>
    <td><input type="text" name="deliver_date" maxlength="10" value="<%=deliver_date%>"> ����ʽ��YYYY-MM-DD��</td>
  </tr>
  <tr>
  	<th>Ԥ�Ƶ������ڣ�</th>
    <td colspan=3><input type="text" name="material_date" maxlength="10" value="<%=material_date%>"> ����ʽ��YYYY-MM-DD��</td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=remark%></textarea></td>
  </tr>
  <input type="hidden" name="goto_url" value="input_order.asp">
  <tr>
    <th colspan="4" align="center"><input type="submit" value="�� ��"> <input type="reset" value="�� ��"></th>
  </tr>
</table>
</form>
</body>
</html>