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
  <th colspan="4" align="center">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_item.asp?item_id=<%=item_id%>');return document.MM_returnValue" value="返 回">
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
  	'response.write "<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;合计&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>"
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
	<th>备 &nbsp;注：</th>
	<td  colspan="<%=title_span+1%>"><%=trans_code(remark)%></td>
</tr>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<br>
<%
end if
%>
</body>
</html>