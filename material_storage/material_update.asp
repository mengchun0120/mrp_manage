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
ordero=request("order")
order1=request.querystring("conid")

if order1="" then
	order1=request.form("conid")
end if

set matrs=conn.execute("select * from material_info where material_id='"&order1&"'")
order=matrs("consume_id")
total=round(cdbl(matrs("total")),2)
if trim(matrs("material_type"))="����" then
set matrs1=conn.execute("select * from unitconsume_out where consume_id='"&order&"'")

%>
<form name=myform1 method=post action="do_material_update.asp">
<input type=hidden name=material_id value="<%=order1%>">
<input type=hidden name=material value="����">
<input type=hidden name=order value="<%=ordero%>">
<table width="100%" cellspacing=1>
<tr>
  <td class="table_title" colspan="4">���ϵ���</td>
</tr>	
<tr>
<th>���</th><td><%=matrs("consume_id")%></td>
<th>����</th><td><%=matrs1("consume_name")%></td>
</tr>
<tr>
<th>��ɫ</th><td><%=matrs1("consume_color")%></td>
<th>�ɷ�</th><td><%=matrs1("consume_chengf")%></td>
</tr>
<tr>
<th>����</th><td><%=matrs1("consume_fuk")%></td>
<th>��λ</th><td><%=matrs1("consume_danw")%></td>
</tr>
<tr>
<th>����</th><td><input type=text name=dashu size=5 value="<%=matrs("number")%>" onchange="caltotal(myform1)"></td>
<th>����</th><td><input type=text name=zhesuan size=5 value="<%=matrs("number_unit")%>" onchange="caltotal(myform1)"></td>
</tr>
<tr>
<th>����</th><td><input type=text name=shuliang value="<%=total%>"></td>
<th>�洢λ��</th><td><input type=text name=weizhi size=10 value="<%=matrs("place")%>"></td>
</tr>
<tr>
<th>���ʱ��</th><td><input type=text name=rktime size=18 value="<%=cstr(matrs("material_time"))%>"></td>
<th>��ע</th><td><textarea name=beizhu size=5><%=matrs("remark")%></textarea></td>
</tr>
<tr><td align=center colspan="4"><input type=submit value="�޸������Ϣ"></td></tr>
</table>
</form>
<%
end if


if trim(matrs("material_type"))="����" then
set matrs2=conn.execute("select * from unitconsume_in where consume_id='"&order&"'")

%>
<form name=myform2 method=post action="do_material_update.asp">
<input type=hidden name=material_id value="<%=order1%>">
<input type=hidden name=material value="����">
<input type=hidden name=order value="<%=ordero%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">���ϵ���</td>
  </tr>	
<tr>
<th>���</th><td><%=matrs("consume_id")%></td>
<th>����</th><td><%=matrs2("consume_name")%></td>
</tr>
<tr>
<th>��ɫ</th><td><%=matrs2("consume_color")%></td>
<th>�ɷ�</th><td><%=matrs2("consume_chengf")%></td>
</tr>
<tr>
<th>����</th><td><%=matrs2("consume_fuk")%></td>
<th>��λ</th><td><%=matrs2("consume_danw")%></td>
</tr>
<tr>
<tr>
<th>����</th><td><input type=text name=dashu size=5 value="<%=matrs("number")%>" onchange="caltotal(myform2)"></td>
<th>����</th><td><input type=text name=zhesuan size=5 value="<%=matrs("number_unit")%>" onchange="caltotal(myform2)"></td>
</tr>
</tr>
<tr>
<th>����</th><td><input type=text name=shuliang value="<%=total%>"></td>
<th>�洢λ��</th><td><input type=text name=weizhi size=10 value="<%=matrs("place")%>"></td>
</tr>
<tr>
<th>���ʱ��</th><td><input type=text name=rktime size=18 value="<%=cstr(matrs("material_time"))%>"></td>
<th>��ע</th><td><textarea name=beizhu size=5><%=matrs("remark")%></textarea></td>
</tr>
<tr><td align=center colspan="4"><input type=submit value="�޸������Ϣ"></td></tr>
</table>
</form>
<%
end if

if trim(matrs("material_type"))="����" then
set matrs3=conn.execute("select * from unitconsume_other where consume_id='"&order&"'")
%>
<form name=myform3 method=post action="do_material_update.asp">
<input type=hidden name=material_id value="<%=order1%>">
<input type=hidden name=material value="����">
<input type=hidden name=order value="<%=ordero%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">���ϵ���</td>
  </tr>	
<tr>
<th>���</th><td><%=matrs("consume_id")%></td>
<th>����</th><td><%=matrs3("consume_name")%></td>
</tr>
<tr>
<th>�ɷ�</th><td><%=matrs3("consume_chengf")%></td>
<th>���</th><td><%=matrs3("consume_fuk")%></td>
</tr>
<tr>
<th>��λ</th><td><%=matrs3("consume_danw")%></td>
<th>����</th><td><input type=text name=dashu size=5 value="<%=matrs("number")%>" onchange="caltotal(myform3)"></td>
<tr>
</tr>
</tr>
<tr>
<th>����</th><td><input type=text name=zhesuan size=5 value="<%=matrs("number_unit")%>" onchange="caltotal(myform3)"></td>
<th>����</th><td><input type=text name=shuliang value="<%=total%>"></td>
</tr>
<tr>
<th>�洢λ��</th><td><input type=text name=weizhi size=10 value="<%=matrs("place")%>"></td>
<th>���ʱ��</th><td><input type=text name=rktime size=18 value="<%=cstr(matrs("material_time"))%>"></td>
</tr>
<tr>
<th>��ע</th><td colspan=3><textarea name=beizhu size=5><%=matrs("remark")%></textarea></td>
</tr>
<tr><td align=center colspan="4"><input type=submit value="�޸������Ϣ"></td></tr>
</table>
</form>
<%
end if

if trim(matrs("material_type"))="�豸" then
set matrs4=conn.execute("select * from unitconsume_equipment where consume_id='"&order&"'")
%>
<form name=myform1 method=post action="do_material_update.asp">
<input type=hidden name=material_id value="<%=order1%>">
<input type=hidden name=material value="�豸">
<input type=hidden name=order value="<%=ordero%>">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">�豸����</td>
  </tr>	
<tr>
<th>���</th><td><%=matrs("consume_id")%></td>
<th>����</th><td><%=matrs4("consume_name")%></td>
</tr>
<tr>
<th>���</th><td><%=matrs4("consume_guig")%></td>
<th>����</th><td><input type=text name=shuliang value="<%=matrs("total")%>"></td>
</tr>
<tr>
<th>�洢λ��</th><td><input type=text name=weizhi size=10 value="<%=matrs("place")%>"></td>
<th>���ʱ��</th><td><input type=text name=rktime size=18 value="<%=cstr(matrs("material_time"))%>"></td>
</tr>
<tr>
<th>��ע</th><td colspan=3><textarea name=beizhu size=5><%=matrs("remark")%></textarea></td>
</tr>
<tr><td align=center colspan="4"><input type=submit value="�޸������Ϣ"></td></tr>
</table>
</form>
<%
end if
%>                                                               