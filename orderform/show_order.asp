<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
set rs4=Server.CreateObject("ADODB.Recordset")
sql4="select order_no from order_info"
rs4.open sql4,conn,1,1
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<form action="show_order.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">��ѯ������Ϣ</td>
  </tr>
  <tr>
    <th align=right width="40%">��ѡ��Ҫ��ѯ�Ķ����ţ�</th>
    <td>
    	<select name="order_no">
    	<%while not rs4.eof%>
      <option><%=rs4("order_no")%></option>
      <%
        rs4.movenext
      wend
      rs4.close
      set rs4=nothing
      %>
      </select>
      <input type="submit" value="�� ѯ"> <input type="reset" value="�� ��">
    </td>
  </tr>
</table>
</form>
<%
if order_no<>"" then
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="select * from order_info where order_no='"&order_no&"'"
  rs.open sql,conn,1,1
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">������<%=order_no%>���Ļ�����Ϣ</td>
  </tr>
  <tr>
    <th align=right>�� �� �ţ�</th>
    <td><%=rs("order_no")%></td>
    <th>��Լ���ƣ�</th>
    <td><%=rs("agreement_name")%></td>
  </tr>
  <tr>
  	<th>�ͻ����ƣ�</th>
    <td><%=rs("client_name")%></td>
    <th>�ͻ�����</th>
    <td><%=rs("client_depute")%></td>
  </tr>
  <tr>
    <th>�� �� �ڣ�</th>
    <td><%=rs("deliver_date")%></td>
    <th>�� �� ����</th>
    <td><%=rs("send_to")%></td>
  </tr>
  <tr>
    <th>�� &nbsp;&nbsp;&nbsp;�ţ�</th>
    <td><%=rs("design_no")%></td>
    <th>��Ʒ���ƣ�</th>
    <td><%=rs("product_name")%></td>
  </tr>
  <tr>
  	<th>�������ڣ�</th>
    <td><%=rs("getmaterial_date")%></td>
    <th>������ڣ�</th>
    <td><%=rs("check_date")%></td>
  </tr>
  <tr>
  	<th>�� �� �ʣ�</th>
    <td><%=rs("add_rate")%>%</td>
    <th>����������</th>
    <td><%=rs("order_amount")%></td>
  </tr>
</table>
<br>
<%
rs.close
set rs=nothing

set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from suborder_info where order_no='"&order_no&"'"
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
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<br>����<br>ɫ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
end if
%>
</table>
<div align=right>�ϼ�������<%=alladdup%></div>
<br>
<center>
<input name="affirm_order" type="button" onclick="MM_goToURL('self','is_item_input_finished.asp?item_id=<%=item_id%>&order_no=<%=order_no%>&goto_url=show_order.asp');return document.MM_returnValue" value="ȷ��¼�����">&nbsp;&nbsp;
<input name="show_order" type="button" onclick="MM_goToURL('self','edit_order.asp?order_no=<%=order_no%>');return document.MM_returnValue" value="�༭��������">
<br><br>
</center>
<%end if%>
</body>
</html>