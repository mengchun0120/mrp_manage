<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
item_id=trim(request("item_id"))
set rs4=Server.CreateObject("ADODB.Recordset")
sql4="select * from item_info order by date_created desc"
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
  	<td class="table_title" colspan="6">请选择要查询的款号：</td>
  </tr>
  <tr>
    <th>款号</th><th>客户名称</th><th>产品名称</th><th>签单日期</th><th>跟单员</th><th>操作</th>
  </tr>
  <%while not rs4.eof
    if  rs4("state")="录入完毕" then%>
  <form action="show_item.asp" method=post target="mainFrame">
  <input type=hidden name="item_id" value="<%=rs4("item_id")%>">
  <tr>
    <td><%=rs4("design_no")%></td><td><%=rs4("client_name")%></td><td><%=rs4("product_name")%></td><td><%=rs4("affix_date")%></td><td><%=rs4("functionary")%></td>
      <td><input type="submit" value="查看详情">
    </td>
  </tr>
  </form>
  <%end if
        rs4.movenext
      wend
      rs4.close
      set rs4=nothing
      %>
</table>

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
    <th>工 &nbsp;&nbsp;&nbsp;时：</th>
    <td><%=rs("man_hour")%> 秒</td>
  </tr>
  <tr>
    <th>描 &nbsp;&nbsp;&nbsp;述：</th>
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
    <th>序号</th>
    <th>订单号 PO.NO</th>
    <th>ULT.DEST</th>
    <th>BR/PL</th>
    <th>地区</th>
    <th>箱唛编号</th>
    <th>数量</th>
    <th>目的地</th>
    <th>验货日期</th>
    <th>交货日期</th>
    <th>预计到料日期</th>
    <th>特别客户</th>
    <th>操作</th>
  </tr>
<%
all_amount=0
while not rs2.eof
  if (rs2("state")<>"录入") then
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
    <td align="center"><a href="check_state.asp?conid=<%=rs2("order_no")%>&kuanid=<%=item_id%>" title="查看 “<%=rs2("order_no")%>” 详细信息"><%=rs2("order_no")%></a></td>
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
    <form action="check_state.asp" method=post target="mainFrame">
    	<input type="hidden" name="conid" value="<%=rs2("order_no")%>">
    	<input type="hidden" name="kuanid" value="<%=item_id%>">
    <th align="center"><input type="submit" value="原料入库"></th>
  </form>
  </tr>
<%end if
	  rs2.movenext
	wend
%>
  <tr>
    <th>备 &nbsp;注：</th>
    <td colspan=12><%=trans_code(rs("remark"))%></td>
  </tr>
</table>
<div align=right>合计数量： <%=all_amount%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;合计订单： <%=serial_no%> 张 &nbsp;&nbsp;</div>
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