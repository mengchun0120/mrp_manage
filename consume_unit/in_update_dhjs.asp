<!--#include file=../inc/conn.asp-->
<html>
	<head>
		<script language=javascript>
			function calcaijian(myform){
				if ((myform.sj.value!="")&&(myform.sh.value!=""))
				      {myform.cj.value=myform.sj.value*(1+myform.sh.value/100);
				       myform.kg.value=myform.cj.value;}
				}
		</script>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
<body>
<table>
	<tr>
  	<td class="table_title" colspan="4">修改单耗中的里料</td>
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
	ys=request.form("ys")
	cf=request.form("cf")
	fk=request.form("fk")
	dw=request.form("dw")
	kg=request.form("kg")
	sj=request.form("sj")
	sh=request.form("sh")
	cj=request.form("cj")
	bz=request.form("bz")
  insql="update unitconsume_in set consume_name='"&mc&"',consume_color='"&ys&"',consume_chengf='"&cf&"',consume_fuk='"&fk&"',consume_danw='"&dw&"',consume_kegyl="&kg&",consume_shijyl="&sj&",consume_sunh="&sh&",consume_caijyl="&cj&",consume_beiz='"&bz&"' where consume_id="&conid&""
  conn.execute(insql)
  response.redirect "ifc_dhjs.asp?conid="&order
end if
xgsql="select * from unitconsume_in where consume_id="&conid&""
set rsxg=conn.execute(xgsql)
if not rsxg.eof then%>
<form name=myform method=post action="in_update_dhjs.asp">
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=order value="<%=rsxg("order_no")%>">
<tr>
<td>序号：</td>
<td><%=conid%></td>
<td>名称：</td>
<td><input type="text" name="mc" size=10 value="<%=rsxg("consume_name")%>"></td>
</tr>
<tr>
<td>颜色：</td>
<td><input type="text" name="ys" size=10 value="<%=rsxg("consume_color")%>"></td>
<td>成分：</td>
<td><input type="text" name="cf" size=10 value="<%=rsxg("consume_chengf")%>"></td>
</tr>
<tr>
<td>幅宽：</td>
<td><input type="text" name="fk" size=3 value="<%=rsxg("consume_fuk")%>"></td>
<td>单位：</td>
<td><input type="text" name="dw" size=3 value="<%=rsxg("consume_danw")%>"></td>
</tr>
<tr>
<td>客供用率：</td>
<td><input type="text" name="kg" size=3 value="<%=rsxg("consume_kegyl")%>"></td>
<td>实际用率：</td>
<td><input type="text" name="sj" size=3 value="<%=rsxg("consume_shijyl")%>"></td>
</tr>
<tr>
<td>损耗：</td>
<td><input type="text" name="sh" size=3 onchange="calcaijian(myform)" value="<%=rsxg("consume_sunh")%>"></td>
<td>裁剪用率：</td>
<td><input type="text" name="cj" size=3 value="<%=rsxg("consume_caijyl")%>"></td>
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