<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="../orderform/inc/check_depart.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
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
  <%remark=rs2("remark")%>
  <th colspan="4" align="center">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_item.asp?item_id=<%=item_id%>');return document.MM_returnValue" value="�� ��">
  </th>
</table>
<br>
<%
rs.close
set rs=nothing
rs2.close
set rs2=nothing
%>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from suborder_info where order_no='"&order_no&"'"
'sql2="select suborder_color from suborder_info where order_no='"&order_no&"' order by suborder_no"
rs2.open sql2,conn,1,1
if not rs2.eof then
	set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from suborder_info where order_no='"&order_no&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=0
  while not rs3.eof
    title_span=title_span+1
    rs3.movenext
  wend
  rs3.movefirst
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="<%=title_span+2%>">������<%=order_no%>���Ķ�������Ϣ</td>
  </tr>
  <tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<br>����<br>ɫ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<%
  	while not rs3.eof
  	  set rs_inlen=Server.CreateObject("ADODB.Recordset")
      sql_inlen="select top 1 suborder_inlen from suborder_info where order_no='"&order_no&"'"
      rs_inlen.open sql_inlen,conn,1,1
  	  response.write "<th>"
  	  response.write rs3("suborder_size")
  	  if rs_inlen("suborder_inlen")<>0 then
  	  	response.write " / "&rs_inlen("suborder_inlen")
  	  end if
  	  response.write "</th>"
  	  rs_inlen.close
  	  set rs_inlen=nothing
  	  rs3.movenext
  	wend
  	response.write "<th>"
  	response.write "�ϼ�"
  	response.write "</th>"
  	'response.write "<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ϼ�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>"
  	rs3.movefirst
  	alladdup=0
  	while not rs2.eof
  	  response.write "<tr><th>"&rs2("suborder_color")&"</th>"
  	  rs3.movefirst
  	  addup=0
  	  while not rs3.eof
  	    set rs4=Server.CreateObject("ADODB.Recordset")
        sql4="select suborder_amount from suborder_info where order_no='"&order_no&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
        'response.write sql4&"<br>"
        rs4.open sql4,conn,1,1
        if trim(rs4("suborder_amount"))="" then
        	response.write "<td align=center>&nbsp;</td>"
        else
        	addup=addup+cint(rs4("suborder_amount"))
          response.write "<td align=center>"&rs4("suborder_amount")&"</td>"
        end if
  	    rs4.close
  	    set rs4=nothing
  	    rs3.movenext
  	  wend
  	  response.write "<td align=center>"&addup&"</td></tr>"
  	  alladdup=alladdup+addup
  	  rs2.movenext
  	wend
  	rs2.close
  	set rs2=nothing
  	rs3.close
  	set rs3=nothing
  end if
%>
<tr>
	<th>�� &nbsp;ע��</th>
	<td  colspan="<%=title_span+1%>"><%=trans_code(remark)%></td>
</tr>
</table>
<div align=right>�ϼ�������<%=alladdup%></div>
<br>
<%
end if
%>
</body>
</html>