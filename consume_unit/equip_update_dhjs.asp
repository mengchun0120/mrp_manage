<!--#include file=../inc/conn.asp-->
<html>
	<head>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
<body>
<table>
	<tr>
  	<td class="table_title" colspan="4">�޸ĵ����е������豸������</td>
  </tr>
<%
conid=request.querystring("conid")
if conid="" then
	conid=request.form("conid")
end if
caozuo=request.form("b")
if (caozuo="����") then
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
<td>��ţ�</td>
<td><%=conid%></td>
<td>���ƣ�</td>
<td><input type="text" name="mc" size=10 value="<%=rsxg("consume_name")%>"></td>
</tr>
<tr>
<td>���</td>
<td><input type="text" name="gg" size=10 value="<%=rsxg("consume_guig")%>"></td>
<td>������</td>
<td><input type="text" name="sl" size=3 value="<%=rsxg("consume_shul")%>"></td>
</tr>
<tr>
<td>��ע��</td>
<td colspan=3><textarea name="bz" cols="30"><%=rsxg("consume_beiz")%></textarea></td>
</tr>
<tr>
<td colspan=4 align=center><input type="submit" name="b" value="����"></td>
</tr>
<%end if%>
</table>
</form>
</body>
</html>