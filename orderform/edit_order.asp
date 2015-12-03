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
	serial_no="（自动编号）"
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
<%if rs("state")="录入" then%>
<form action="modify_order.asp" method=post target="mainFrame">
	<input type="hidden" name="order_no" value="<%=order_no%>">
  <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
  <input type="hidden" name="serial_no" value="<%=serial_no%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">修改订单“<%=order_no%>”的基本信息</td>
  </tr>
  <tr>
    <th align=right width="15%">序 &nbsp;&nbsp;&nbsp;号：</th>
    <td width="35%"><%=serial_no%></td>
    <th width="15%">定单号 PO.NO：</th>
    <td width="35%"><%=rs("order_no")%> （禁止修改！）</td>
  </tr>
  <tr>
  	<th>ULT.DEST：</th>
    <td><input type="text" name="ult_dest" value="<%=rs("ult_dest")%>"> （少于25字）</td>
    <th>BR/PL：</th>
    <td><input type="text" name="br_pl" value="<%=rs("br_pl")%>"> （少于25字）</td>
  </tr>
  <tr>
    <th>地 &nbsp;&nbsp;&nbsp;区：</th>
    <td><input type="text" name="area" value="<%=rs("area")%>"> （少于25字）</td>
    <th>箱唛编号：</th>
    <td><input type="text" name="chest_no" value="<%=rs("chest_no")%>"> （少于25字）</td>
  </tr>
  <tr>
    <th>目 的 地：</th>
    <td><input type="text" name="destination" value="<%=rs("destination")%>"> （少于25字）</td>
    <th>特别客户：</th>
    <td><input type="text" name="special_client" value="<%=rs("special_client")%>"> （少于25字）</td>
  </tr>
  <tr>
  	<th>验货日期：</th>
    <td><input type="text" name="checkup_date" maxlength="10" value="<%=rs("checkup_date")%>"> （格式：YYYY-MM-DD）</td>
    <th>交货日期：</th>
    <td><input type="text" name="deliver_date" maxlength="10" value="<%=rs("deliver_date")%>"> （格式：YYYY-MM-DD）</td>
  </tr>
  <tr>
  	<th>预计到料日期：</th>
    <td colspan=3><input type="text" name="material_date" maxlength="10" value="<%=rs("material_date")%>"> （格式：YYYY-MM-DD）</td>
  </tr>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=rs("remark")%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="修 改"> <input type="reset" value="还 原">
    	<input name="edit_item" type="button" onclick="MM_goToURL('self','edit_item.asp?item_id=<%=rs("item_id")%>');return document.MM_returnValue" value="返 回">
    </th>
  </tr>
</table>
</form>
<%else%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">订单“<%=order_no%>”的基本信息</td>
  </tr>
  <tr>
    <th align=right width="15%">序 &nbsp;&nbsp;&nbsp;号：</th>
    <td width="35%"><%=serial_no%></td>
    <th width="15%">定单号 PO.NO：</th>
    <td width="35%"><%=rs("order_no")%></td>
  </tr>
  <tr>
  	<th>ULT.DEST：</th>
    <td><%=rs("ult_dest")%></td>
    <th>BR/PL：</th>
    <td><%=rs("br_pl")%></td>
  </tr>
  <tr>
    <th>地 &nbsp;&nbsp;&nbsp;区：</th>
    <td><%=rs("area")%></td>
    <th>箱唛编号：</th>
    <td><%=rs("chest_no")%></td>
  </tr>
  <tr>
    <th>目 的 地：</th>
    <td><%=rs("destination")%></td>
    <th>特别客户：</th>
    <td><%=rs("special_client")%></td>
  </tr>
  <tr>
  	<th>验货日期：</th>
    <td><%=rs("checkup_date")%></td>
    <th>交货日期：</th>
    <td><%=rs("deliver_date")%></td>
  </tr>
  <tr>
  	<th>预计到料日期：</th>
    <td colspan=3><%=rs("material_date")%></td>
  </tr>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan=3><%=trans_code(rs("remark"))%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center">
    	<input name="edit_item" type="button" onclick="MM_goToURL('self','edit_item.asp?item_id=<%=rs("item_id")%>');return document.MM_returnValue" value="返 回">
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
  	<td class="table_title" colspan=6>修改已录订单项信息</td>
  </tr>
  <tr>
    <th>序号</th>
    <th>色号</th>
    <th>尺码</th>
    <th>内长</th>
    <th>数量</th>
    <th>编辑</th>
  </tr>
<%
while not rs2.eof
  sub_serial_no=sub_serial_no+1
%>
<%if rs("state")="录入" then%>
<form action="modify_suborder.asp" method=post target="mainFrame">
  <tr>
    <th><%=sub_serial_no%></th>
    <input type="hidden" name="suborder_no" value="<%=rs2("suborder_no")%>">
    <input type="hidden" name="order_no" value="<%=order_no%>">
    <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
    <input type="hidden" name="serial_no" value="<%=serial_no%>">
    <input type="hidden" name="goto_url" value="edit_order.asp">
    <td align="center"><input type="text" name="suborder_color" value="<%=rs2("suborder_color")%>" size="20">（少于25字）</td>
    <td align="center"><input type="text" name="suborder_size" value="<%=rs2("suborder_size")%>" size="6">（少于25字）</td>
    <td align="center"><input type="text" name="suborder_inlen" value="<%=rs2("suborder_inlen")%>" size="6">（数字，可为空）</td>
    <td align="center"><input type="text" name="suborder_amount" value="<%=rs2("suborder_amount")%>" size="8">（数字）</td>
    <th align="center"><input type="submit" value="修 改">
    <input type="reset" value="还 原">
    <input name="del_suborder" type="button" onclick="MM_goToURL('self','is_del_suborder.asp?suborder_no=<%=rs2("suborder_no")%>&order_no=<%=order_no%>&item_id=<%=rs("item_id")%>&serial_no=<%=serial_no%>&goto_url=edit_order.asp');return document.MM_returnValue" value="删 除"></th>
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
    <td align="center"><input type="text" name="suborder_inlen" value="<%=rs2("suborder_inlen")%>" size="6">（数字，可为空）</td>
    <td align="center"><input type="text" name="suborder_amount" value="<%=rs2("suborder_amount")%>" size="8">（数字）</td>
    <th align="center"><input type="submit" value="修 改">
    <input type="reset" value="还 原">
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
<%if rs("state")="录入" then%>
<form action="add_suborder.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="5">增加订单项</td>
  </tr>
  <tr>
    <th>序号</th>
    <th>色号</th>
    <th>尺码</th>
    <th>内长</th>
    <th>数量</th>
  </tr>
  <tr>
    <th><%=sub_serial_no+1%></th>
    <td align="center"><input type="text" name="suborder_color" size="25" value="<%=suborder_color%>">（少于25字）</td>
    <td align="center"><input type="text" name="suborder_size" size="11">（少于25字）</td>
    <td align="center"><input type="text" name="suborder_inlen" size="11" value="<%=suborder_inlen%>">（数字，可为空）</td>
    <td align="center"><input type="text" name="suborder_amount" size="13">（数字）</td>
    <input type="hidden" name="order_no" value="<%=order_no%>">
    <input type="hidden" name="item_id" value="<%=rs("item_id")%>">
    <input type="hidden" name="serial_no" value="<%=serial_no%>">
    <input type="hidden" name="goto_url" value="edit_order.asp">
  </tr>
  <tr>
    <th colspan="5" align="center"><input type="submit" value="提 交"> <input type="reset" value="重 置"></th>
  </tr>
</table>
</form>
<center>
<input name="affirm_order" type="button" onclick="MM_goToURL('self','is_item_input_finished.asp?item_id=<%=rs("item_id")%>&order_no=<%=order_no%>&goto_url=edit_order.asp');return document.MM_returnValue" value="确认录入完成">&nbsp;&nbsp;
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