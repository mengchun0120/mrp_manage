<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<%

conid=request.querystring("material_id")
order=request("order")

material=request.querystring("material")
if conid="" then
	conid=request.form("material_id")
end if
if material="" then
	material=request.form("material")
end if

dashu=request.form("dashu")
zhesuan=request.form("zhesuan")
weizhi=request.form("weizhi")
beizhu=request.form("beizhu")
material_time=request.form("rktime")
shuliang=request.form("shuliang")

if material="�豸" then
set matu=conn.execute("update material_info set total="&shuliang&",place='"&weizhi&"',remark='"&beizhu&"',material_time='"&material_time&"' where material_id="&conid&"")
else
set matu=conn.execute("update material_info set total="&shuliang&",place='"&weizhi&"',remark='"&beizhu&"',material_time='"&material_time&"',number="&dashu&",number_unit="&zhesuan&" where material_id="&conid&"")
end if 
time_out=0
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=ifc_yuanliaoruku.asp?conid=<%=order%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">�޸Ľ��</td>
  		</tr>
  		<tr>
  			<td align="center">�޸ĳɹ���</td>
  		</tr>
  	</table>
  </body>
</html>