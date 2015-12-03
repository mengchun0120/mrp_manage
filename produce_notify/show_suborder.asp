<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from order_info where order_no='"&order_no&"'"
rs2.open sql2,conn,1,1
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from item_info where item_id='"&rs2("item_id")&"'"
rs.open sql,conn,1,1
%>
<%'=order_no&"|"&item_id&"|"&notify_no%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">生产项“<%=rs2("item_id")%>”以及订单“<%=order_no%>”的基本信息</td>
  </tr>
  <tr>
  	<th width="15%">客户名称：</th>
    <td width="35%"><%=rs("client_name")%></td>
    <th width="15%">跟 单 员：</th>
    <td width="35%"><%=rs("functionary")%></td>
  </tr>
  <tr>
    <th>款 &nbsp;&nbsp;&nbsp;号：</th>
    <td><%=rs("design_no")%></td>
    <th>产品名称：</th>
    <td><%=rs("product_name")%></td>
  </tr>
  <tr>
    <th>签单日期：</th>
    <td><%=rs("affix_date")%></td>
    <th>预计到料日期：</th>
    <td><%=rs2("material_date")%></td>
  </tr>
  <tr>
    <th>验货日期：</th>
    <td><%=rs2("checkup_date")%></td>
    <th>交货日期：</th>
    <td><%=rs2("deliver_date")%></td>
  </tr>
  <tr>
    <th>订 单 号：</th>
    <td><%=rs2("order_no")%></td>
    <th>目 的 地：</th>
    <td><%=rs2("destination")%></td>
  </tr>
  <tr>
    <th>描 &nbsp;&nbsp;&nbsp;述：</th>
    <td colspan=3><%=rs("description")%></td>
  </tr>
  <%remark=rs2("remark")%>
  <tr>
    <th colspan="4" align="center">
      <input name="input_order" type="button" onclick="MM_goToURL('self','show_item.asp?item_id=<%=item_id%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="返 回">
    </th>
  </tr>
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
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from suborder_info where order_no='"&order_no&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=rs3.recordcount
%>
<form method=post action="add_produce_amount.asp">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="<%=title_span+2%>">订单“<%=order_no%>”的订单项信息</td>
  </tr>
  <tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尺码<br>数量<br>色号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
  	response.write "合计"
  	response.write "</th>"
  	rs3.movefirst
  	alladdup=0
  	while not rs2.eof
  	  response.write "<tr><th>"&rs2("suborder_color")&"</th>"
  	  rs3.movefirst
  	  addup=0
  	  while not rs3.eof
  	    set rs4=Server.CreateObject("ADODB.Recordset")
        sql4="select suborder_amount,suborder_no from suborder_info where order_no='"&order_no&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
        rs4.open sql4,conn,1,1
        if trim(rs4("suborder_amount"))="" then
        	response.write "<td align=center>&nbsp;</td>"
        else
        	produce_amount_sum=0
        	set rs5=Server.CreateObject("ADODB.Recordset")
          sql5="select sum(produce_amount) as produce_amount_sum from notify_produce_info where suborder_no='"&rs4("suborder_no")&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
          rs5.open sql5,conn,1,1
          produce_amount_sum=cint(rs5("produce_amount_sum"))
          'response.write sql5&"|||"&produce_amount_sum&"|||"&rs5("produce_amount_sum")
          addup=addup+cint(rs4("suborder_amount"))-produce_amount_sum
          response.write "<td align=center>"&cint(rs4("suborder_amount"))-produce_amount_sum
          %>
          <input type=text size=5 name="produce_amount">
          <input type=hidden name="suborder_no" value="<%=rs4("suborder_no")%>">
          <input type=hidden name="suborder_color" value="<%=rs2("suborder_color")%>">
          <input type=hidden name="suborder_size" value="<%=rs3("suborder_size")%>">
          </td>
          <%
          rs5.close
  	      set rs5=nothing
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
	<th>备 &nbsp;注：</th>
	<td  colspan="<%=title_span+1%>"><%=trans_code(remark)%></td>
</tr>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<%end if%>
<br>
<center>
<input type=hidden name="notify_no" value="<%=notify_no%>">
<input type=hidden name="order_no" value="<%=order_no%>">
<input type=hidden name="item_id" value="<%=item_id%>">
<input type=hidden name="design_no" value="<%=design_no%>">
<input name="affirm_order" type="submit" value="确认输入">
<input name="affirm_order" type="reset" value="重新输入">
</form>
<br><br>
</center>
</body>
</html>