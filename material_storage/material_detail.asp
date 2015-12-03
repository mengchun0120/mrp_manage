<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<html>
<head>
<script language=javascript>
function caltotal(myform){
if ((myform.dashu.value!="")&&(myform.zhesuan.value!=""))
{myform.shuliang.value=myform.dashu.value*myform.zhesuan.value;
 }
}
</script>
  <link href="../css/global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=0 leftmargin=0>
<%
order=request("order")
conid=request("conid")
material=request.querystring("material")
if conid="" then
	conid=request.form("conid")
end if
if material="" then
	material=request.form("material")
end if

if material="面料" then
set matrs1=conn.execute("select * from unitconsume_out where consume_id='"&conid&"'")
set matrs11=conn.execute("select * from material_info where consume_id='"&conid&"' and material_type='面料'")
%>
<table width="100%" cellspacing=1>
<tr>
  <td class="table_title" colspan="13">面料单耗</td>
</tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>颜色</th>
<th>成份</th>
<th>幅宽</th>
<th>单位</th>
<th>大数</th>
<th>折算</th>
<th>数量</th>
<th>存储位置</th>
<th>入库时间</th>
<th>备注</th>
<th>操作</th>
</tr>
<%
i=1
do while (not matrs11.eof)
total=round(cdbl(matrs11("total")),2)
%>
<form method=post action="material_update.asp"> 
<input type="hidden" name=conid value="<%=matrs11("material_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><a href="material_update.asp?conid=<%=matrs11("material_id")%>&order=<%=order%>"><%=matrs1("consume_name")%></a></td>
<td><%=matrs1("consume_color")%></td>
<td><%=matrs1("consume_chengf")%></td>
<td><%=matrs1("consume_fuk")%></td>
<td><%=matrs1("consume_danw")%></td>
<td><%=matrs11("number")%></td>
<td><%=matrs11("number_unit")%></td>
<td><%=total%></td>
<td><%=matrs11("place")%></td>
<td><%=matrs11("material_time")%></td>
<td><%=matrs11("remark")%></td>
<td><input type=submit value="修改原料">
<input name="conid" type="button" onclick="MM_goToURL('self','material_delete.asp?conid=<%=matrs11("material_id")%>&order=<%=order%>');return document.MM_returnValue" value="删除"></td>
</tr>
</form>
<%
i=i+1
matrs11.movenext
loop
rktime=cstr(now())
%>
<form name=myform1 method=post action="material_add.asp"> 
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=material value="面料">
<input type="hidden" name=material_time value="<%=rktime%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><%=matrs1("consume_name")%></td>
<td><%=matrs1("consume_color")%></td>
<td><%=matrs1("consume_chengf")%></td>
<td><%=matrs1("consume_fuk")%></td>
<td><%=matrs1("consume_danw")%></td>
<td><input type=text name=dashu size=5 onchange="caltotal(myform1)"></td>
<td><input type=text name=zhesuan size=5 onchange="caltotal(myform1)"></td>
<td><input type=text name=shuliang size=5></td>
<td><input type=text name=weizhi size=10></td>
<td><%=rktime%></td>
<td><textarea name=beizhu size=5></textarea></td>
<td><input type=submit value="添加入库"></td>
</tr>
</form>
</table>
<%
end if


if material="里料" then
set matrs2=conn.execute("select * from unitconsume_in where consume_id='"&conid&"'")
set matrs22=conn.execute("select * from material_info where consume_id='"&conid&"' and material_type='里料'")
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">里料单耗</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>颜色</th>
<th>成份</th>
<th>幅宽</th>
<th>单位</th>
<th>大数</th>
<th>折算</th>
<th>数量</th>
<th>存储位置</th>
<th>入库时间</th>
<th>备注</th>
<th>操作</th>
</tr>
<%
i=1
do while (not matrs22.eof)
total=round(cdbl(matrs22("total")),2)
%>
<form method=post action="material_update.asp"> 
<input type="hidden" name=conid value="<%=matrs22("material_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><a href="material_update.asp?conid=<%=matrs22("material_id")%>&order=<%=order%>"><%=matrs2("consume_name")%></a></td>
<td><%=matrs2("consume_color")%></td>
<td><%=matrs2("consume_chengf")%></td>
<td><%=matrs2("consume_fuk")%></td>
<td><%=matrs2("consume_danw")%></td>
<td><%=matrs22("number")%></td>
<td><%=matrs22("number_unit")%></td>
<td><%=total%></td>
<td><%=matrs22("place")%></td>
<td><%=matrs22("material_time")%></td>
<td><%=matrs22("remark")%></td>
<td><input type=submit value="修改原料"><input name="conid" type="button" onclick="MM_goToURL('self','material_delete.asp?conid=<%=matrs22("material_id")%>&order=<%=order%>');return document.MM_returnValue" value="删除"></td>
</tr>
</form>
<%
i=i+1
matrs22.movenext
loop
rktime=cstr(now())
%>
<form name=myform2 method=post action="material_add.asp"> 
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=material value="里料">
<input type="hidden" name=material_time value="<%=rktime%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><%=matrs2("consume_name")%></td>
<td><%=matrs2("consume_color")%></td>
<td><%=matrs2("consume_chengf")%></td>
<td><%=matrs2("consume_fuk")%></td>
<td><%=matrs2("consume_danw")%></td>
<td><input type=text name=dashu size=5 onchange="caltotal(myform2)"></td>
<td><input type=text name=zhesuan size=5 onchange="caltotal(myform2)"></td>
<td><input type=text name=shuliang size=5></td>
<td><input type=text name=weizhi size=10></td>
<td><%=rktime%></td>
<td><textarea name=beizhu size=5></textarea></td>
<td><input type=submit value="添加入库"></td>
</tr>
</form>
</table>
<%
end if

if material="辅料" then
set matrs3=conn.execute("select * from unitconsume_other where consume_id='"&conid&"'")
set matrs33=conn.execute("select * from material_info where consume_id='"&conid&"' and material_type='辅料'")
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">辅料单耗</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>成份</th>
<th>规格</th>
<th>单位</th>
<th>大数</th>
<th>折算</th>
<th>数量</th>
<th>存储位置</th>
<th>入库时间</th>
<th>备注</th>
<th>操作</th>
</tr>
<%
i=1
do while not matrs33.eof
total=round(cdbl(matrs33("total")),2)
%>
<form method=post action="material_update.asp"> 
<input type="hidden" name=conid value="<%=matrs33("material_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><a href="material_update.asp?conid=<%=matrs33("material_id")%>&order=<%=order%>"><%=matrs3("consume_name")%></a></td>
<td><%=matrs3("consume_chengf")%></td>
<td><%=matrs3("consume_fuk")%></td>
<td><%=matrs3("consume_danw")%></td>
<td><%=matrs33("number")%></td>
<td><%=matrs33("number_unit")%></td>
<td><%=total%></td>
<td><%=matrs33("place")%></td>
<td><%=matrs33("material_time")%></td>
<td><%=matrs33("remark")%></td>
<td><input type=submit value="修改原料"><input name="conid" type="button" onclick="MM_goToURL('self','material_delete.asp?conid=<%=matrs33("material_id")%>&order=<%=order%>');return document.MM_returnValue" value="删除"></td>
</tr>
</form>
<%
i=i+1
matrs33.movenext
loop
rktime=cstr(now())
%>
<form name=myform3 method=post action="material_add.asp"> 
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=material value="辅料">
<input type="hidden" name=material_time value="<%=rktime%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><%=matrs3("consume_name")%></td>
<td><%=matrs3("consume_chengf")%></td>
<td><%=matrs3("consume_fuk")%></td>
<td><%=matrs3("consume_danw")%></td>
<td><input type=text name=dashu size=5 onchange="caltotal(myform3)"></td>
<td><input type=text name=zhesuan size=5 onchange="caltotal(myform3)"></td>
<td><input type=text name=shuliang size=5></td>
<td><input type=text name=weizhi size=10></td>
<td><%=rktime%></td>
<td><textarea name=beizhu size=5></textarea></td>
<td><input type=submit value="添加入库"></td>
</tr>
</form>

</table>
<%
end if

if material="设备" then
set matrs4=conn.execute("select * from unitconsume_equipment where consume_id='"&conid&"'")
set matrs44=conn.execute("select * from material_info where consume_id='"&conid&"' and material_type='设备'")
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">设备单耗</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>规格</th>
<th>数量</th>
<th>存储位置</th>
<th>入库时间</th>
<th>备注</th>
<th>操作</th>
</tr>
<%
i=1
do while not matrs44.eof
%>
<form method=post action="material_update.asp"> 
<input type="hidden" name=conid value="<%=matrs44("material_id")%>">
<input type="hidden" name=material value="设备">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><a href="material_update.asp?conid=<%=matrs44("material_id")%>&order=<%=order%>"><%=matrs4("consume_name")%></a></td>
<td><%=matrs4("consume_guig")%></td>
<td><%=matrs44("total")%></td>
<td><%=matrs44("place")%></td>
<td><%=matrs44("material_time")%></td>
<td><%=matrs44("remark")%></td>
<td><input type=submit value="修改原料"><input name="conid" type="button" onclick="MM_goToURL('self','material_delete.asp?conid=<%=matrs44("material_id")%>&order=<%=order%>');return document.MM_returnValue" value="删除"></td>
</tr>
</form>
<%
i=i+1
matrs44.movenext
loop
rktime=cstr(now())
%>
<form method=post action="material_add.asp"> 
<input type="hidden" name=conid value="<%=conid%>">
<input type="hidden" name=material value="设备">
<input type="hidden" name=material_time value="<%=cstr(rktime)%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=i%></td>
<td><%=matrs4("consume_name")%></td>
<td><%=matrs4("consume_guig")%></td>
<td><input type=text name=dashu></td>
<td><input type=text name=weizhi></td>
<td><%=rktime%></td>
<td><textarea name=beizhu></textarea></td>
<td><input type=submit value="添加入库"></td>
</tr>
</form>
</table>
<%
end if
%>                                                               