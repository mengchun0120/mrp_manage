<!--#include file=../inc/conn.asp-->
<html>
	<head>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
<body>
<table>
	<tr>
  	<td class="table_title" colspan="4">�޸ĵ����еĸ���</td>
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
	cf=request.form("cf")
	fk=request.form("fk")
	dw=request.form("dw")
	cj=request.form("cj")
	bz=request.form("bz")
  insql="update unitconsume_other set consume_name='"&mc&"',consume_chengf='"&cf&"',consume_fuk='"&fk&"',consume_danw='"&dw&"',consume_danh="&cj&",consume_beiz='"&bz&"' where consume_id="&conid&""
  conn.execute(insql)
  response.redirect "ifc_dhjs.asp?conid="&order
end if
xgsql="select * from unitconsume_other where consume_id="&conid&""
set rsxg=conn.execute(xgsql)
if not rsxg.eof then%>
<form name=myform method=post action="other_update_dhjs.asp">
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=order value="<%=rsxg("order_no")%>">
<tr>
<td>��ţ�</td>
<td><%=conid%></td>
<td>���ƣ�</td>
<td><input type="text" name="mc" size=10 value="<%=rsxg("consume_name")%>"></td>
</tr>
<tr>
<td>�ɷ֣�</td>
<td><input type="text" name="cf" size=10 value="<%=rsxg("consume_chengf")%>"></td>
<td>����</td>
<td><input type="text" name="fk" size=3 value="<%=rsxg("consume_fuk")%>"></td>
</tr>
<tr>
<td>��λ��</td>
<td><input type="text" name="dw" size=3 value="<%=rsxg("consume_danw")%>"></td>
<td>���ģ�</td>
<td><input type="text" name="cj" size=3 value="<%=rsxg("consume_danh")%>"></td>
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