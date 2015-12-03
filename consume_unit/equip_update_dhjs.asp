<!--#include file=../inc/conn.asp-->
<html>
	<head>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
<body>
<table>
	<tr>
  	<td class="table_title" colspan="4">修改单耗中的特殊设备及工具</td>
  </tr>
<%
conid=request.querystring("conid")
if conid="" then
	conid=request.form("conid")
end if
caozuo=request.form("b")
if (caozuo="更新") then
	order=request("order")
	mc=request.form("mc")
	cf=request.form("gg")
	fk=request.form("sl")
	bz=request.form("bz")
  insql="update unitconsume_equipment set consume_name='"&mc&"',consume_guig='"&cf&"',consume_shul='"&fk&"',consume_beiz='"&bz&"' where consume_id="&conid&""
  conn.execute(insql)
  response.redirect "ifc_dhjs.asp?conid="&order
end if
xgsql="select * from unitconsume_equipment where consume_id="&conid&""
set rsxg=conn.execute(xgsql)
if not rsxg.eof then%>
<form name=myform method=post action="equip_update_dhjs.asp">
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=order value="<%=rsxg("order_no")%>">
<tr>
<td>序号：</td>
<td><%=conid%></td>
<td>名称：</td>
<td><input type="text" name="mc" size=10 value="<%=rsxg("consume_name")%>"></td>
</tr>
<tr>
<td>规格：</td>
<td><input type="text" name="gg" size=10 value="<%=rsxg("consume_guig")%>"></td>
<td>数量：</td>
<td><input type="text" name="sl" size=3 value="<%=rsxg("consume_shul")%>"></td>
</tr>
<tr>
<td>备注：</td>
<td colspan=3><textarea name="bz" cols="30"><%=rsxg("consume_beiz")%></textarea></td>
</tr>
<tr>
<td colspan=4 align=center><input type="submit" name="b" value="更新"></td>
</tr>
<%end if%>
</table>
</form>
</body>
</html>