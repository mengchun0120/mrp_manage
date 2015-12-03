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
<%if rs("state")="录入" then%>
<form action="modify_item.asp" method=post target="mainFrame">
	<input type="hidden" name="item_id" value="<%=item_id%>">
	<input type="hidden" name="functionary" value="<%=functionary%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">修改生产项“<%=item_id%>”的基本信息</td>
  </tr>
  <tr>
  	<th width="15%">客户名称：</th>
    <td width="35%"><input type="text" name="client_name" maxlength="25" value="<%=rs("client_name")%>"> （少于25字）</td>
    <th width="15%">跟 单 员：</th>
    <td width="35%"><%=rs("functionary")%><!--<input type="text" name="functionary" maxlength="5" value="<%=rs("functionary")%>">--></td>
  </tr>
  <tr>
    <th>款 &nbsp;&nbsp;&nbsp;号：</th>
    <td><%=rs("design_no")%> （禁止修改！）</td>
    <th>产品名称：</th>
    <td><input type="text" name="product_name" maxlength="50" value="<%=rs("product_name")%>"> （少于50字）</td>
  </tr>
  <tr>
  	<th>签单日期：</th>
    <td><input type="text" name="affix_date" maxlength="10" value="<%=rs("affix_date")%>"> （格式：YYYY-MM-DD）</td>
    <th>工 &nbsp;&nbsp;&nbsp;时：</th>
    <td><input type="text" name="man_hour" maxlength="10" value="<%=rs("man_hour")%>"> 秒（格式：数字）</td>
  </tr>
  <tr>
    <th>描 &nbsp;&nbsp;&nbsp;述：</th>
    <td colspan=3><input type="text" name="description" size=80 maxlength="100" value="<%=rs("description")%>">  （少于100字）</td>
  </tr>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=rs("remark")%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="修 改"> <input type="reset" value="还 原"> <input name="del_item" type="button" onclick="MM_goToURL('self','is_del_item.asp?item_id=<%=item_id%>&goto_url=edit_item.asp');return document.MM_returnValue" value="删 除"> <input name="edit_item" type="button" onclick="MM_goToURL('self','list_item.asp');return document.MM_returnValue" value="返 回"></th>
  </tr>
</table>
</form>
<%else%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">生产项“<%=item_id%>”的基本信息</td>
  </tr>
  <tr>
  	<th width="15%">客户名称：</th>
    <td width="35%"><%=rs("client_name")%></td>
    <th width="15%">跟 单 员：</th>
    <td width="35%"><%=rs("functionary")%><!--<input type="text" name="functionary" maxlength="5" value="<%=rs("functionary")%>">--></td>
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
    <td><%=rs("man_hour")%></td>
  </tr>
  <tr>
    <th>描 &nbsp;&nbsp;&nbsp;述：</th>
    <td colspan=3><%=rs("description")%></td>
  </tr>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan=3><%=trans_code(rs("remark"))%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input name="edit_item" type="button" onclick="MM_goToURL('self','list_item.asp');return document.MM_returnValue" value="返 回"></th>
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
  	<td class="table_title" colspan="14">已录订单基本信息</td>
  </tr>
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
    <th colspan=2>操作</th>
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
    <td align="center"><a href="edit_order.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>" title="编辑订单 “<%=rs2("order_no")%>” "><%=rs2("order_no")%></a></td>
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
    <th align="center"><input type="submit" value="编 辑">
    	<%if rs("state")="录入" then%>
    	  <input name="del_order" type="button" onclick="MM_goToURL('self','is_del_order.asp?order_no=<%=rs2("order_no")%>&item_id=<%=item_id%>&goto_url=edit_item.asp');return document.MM_returnValue" value="删 除">
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
<%if rs("state")="录入" then%>
<form action="add_order.asp" method=post target="mainFrame">
	<input type="hidden" name="item_id" value="<%=item_id%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">增加订单基本信息</td>
  </tr>
  <tr>
    <th align=right width="15%">序 &nbsp;&nbsp;&nbsp;号：</th>
    <td width="35%"><%=serial_no+1%></td>
    <th width="15%">定单号 PO.NO：</th>
    <td width="35%"><input type="text" name="order_no"> （少于25字）</td>
  </tr>
  <tr>
  	<th>ULT.DEST：</th>
    <td><input type="text" name="ult_dest"> （少于25字）</td>
    <th>BR/PL：</th>
    <td><input type="text" name="br_pl"> （少于25字）</td>
  </tr>
  <tr>
    <th>地 &nbsp;&nbsp;&nbsp;区：</th>
    <td><input type="text" name="area"> （少于25字）</td>
    <th>箱唛编号：</th>
    <td><input type="text" name="chest_no"> （少于25字）</td>
  </tr>
  <tr>
    <th>目 的 地：</th>
    <td><input type="text" name="destination"> （少于25字）</td>
    <th>特别客户：</th>
    <td><input type="text" name="special_client"> （少于25字）</td>
  </tr>
  <tr>
  	<th>验货日期：</th>
    <td><input type="text" name="checkup_date" maxlength="10"> （格式：YYYY-MM-DD）</td>
    <th>交货日期：</th>
    <td><input type="text" name="deliver_date" maxlength="10"> （格式：YYYY-MM-DD）</td>
  </tr>
  <tr>
  	<th>预计到料日期：</th>
    <td colspan=3><input type="text" name="material_date" maxlength="10"> （格式：YYYY-MM-DD）</td>
  </tr>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4></textarea></td>
  </tr>
  <input type="hidden" name="goto_url" value="edit_item.asp">
  <tr>
    <th colspan="4" align="center"><input type="submit" value="提 交"> <input type="reset" value="重 置"></th>
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