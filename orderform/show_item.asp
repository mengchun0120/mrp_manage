<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next
order_by=trim(request("order_by"))
if order_by="" then
	order_by="date_created"
end if
item_id=trim(request("item_id"))
set rs4=Server.CreateObject("ADODB.Recordset")
sql4="select * from item_info order by "&order_by
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
  	<td class="table_title" colspan="8">��ѡ��Ҫ��ѯ�Ŀ��</td>
  </tr>
  <tr>
    <th><a href="show_item.asp?item_id=<%=item_id%>&order_by=item_id">���</a></th><th><a href="show_item.asp?item_id=<%=item_id%>&order_by=client_name">�ͻ�����</a></th><th><a href="show_item.asp?item_id=<%=item_id%>&order_by=product_name">��Ʒ����</a></th><th><a href="show_item.asp?item_id=<%=item_id%>&order_by=affix_date">ǩ������</a></th><th>�����������</th><th><a href="show_item.asp?item_id=<%=item_id%>&order_by=functionary">����Ա</a></th><th><a href="show_item.asp?item_id=<%=item_id%>&order_by=state">״̬</a></th><th>����</th>
  </tr>
  <%
  while not rs4.eof
    set rs5=Server.CreateObject("ADODB.Recordset")
    sql5="select top 1 deliver_date from order_info where item_id='"&rs4("item_id")&"' order by deliver_date"
    'response.write sql5
    rs5.open sql5,conn,1,1
    is_modify="no"
    'response.write "|"&rs4("last_modify")&"|"
    if rs4("last_modify")="0" then
    	set rs6=Server.CreateObject("ADODB.Recordset")
      sql6="select * from order_info where item_id='"&rs4("item_id")&"' and last_modify<>'0'"
      rs6.open sql6,conn,1,1
      if rs6.eof then
      	set rs7=Server.CreateObject("ADODB.Recordset")
        sql7="select order_no from order_info where item_id='"&rs4("item_id")&"'"
        'response.write sql7
        rs7.open sql7,conn,1,1
        while not rs7.eof 
        	set rs8=Server.CreateObject("ADODB.Recordset")
          sql8="select * from suborder_info where order_no='"&rs7("order_no")&"' and last_modify<>'0'"
          'response.write sql8
          rs8.open sql8,conn,1,1
          if not rs8.eof then
        	  is_modify="yes"
        	end if
        	rs8.close
        	set rs8=nothing
        	rs7.movenext
        wend
        rs7.close
        set rs7=nothing
      else
      	is_modify="yes"
      end if
      rs6.close
      set rs6=nothing
    else
    	is_modify="yes"
    end if
  %>
  <form action="show_item.asp" method=post target="mainFrame">
  <input type=hidden name="item_id" value="<%=rs4("item_id")%>">
  <input type=hidden name="order_by" value="<%=order_by%>">
  <tr>
  	<%
  	if is_modify="yes" then
  	  response.write "<td align=center><font color=#ffff00>"&rs4("design_no")&"</font></td>"
  	else
  		response.write "<td align=center>"&rs4("design_no")&"</td>"
  	end if
  	%>
    <td align=center><%=rs4("client_name")%></td><td align=center><%=rs4("product_name")%></td><td align=center><%=rs4("affix_date")%></td>
    <td align=center><%=rs5("deliver_date")%></td><td align=center><%=rs4("functionary")%></td><td align=center><%=rs4("state")%></td>
    <td align=center><input type="submit" value="�鿴����"></td>
  </tr>
  </form>
  <%
        rs4.movenext
        rs5.close
        set rs5=nothing
      wend
      rs4.close
      set rs4=nothing
      %>
</table>
<br>
<%
if item_id<>"" then
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from item_info where item_id='"&item_id&"'"
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
sql2="select * from order_info where item_id='"&item_id&"' order by date_created"
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
  'response.write all_amount&"||"
  rs3.close
  set rs3=nothing
%>
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><a href="show_suborder.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>" title="�鿴 ��<%=rs2("order_no")%>�� ��ϸ��Ϣ"><%=rs2("order_no")%></a></td>
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
<br>
</body>
</html>