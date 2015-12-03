<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<%
order=request("order")
conid=request.querystring("conid")
material=request.querystring("material")
if conid="" then
	conid=request.form("conid")
end if
if material="" then
	material=request.form("material")
end if

dashu=request.form("dashu")
zhesuan=request.form("zhesuan")
weizhi=request.form("weizhi")
beizhu=request.form("beizhu")
material_time=request.form("material_time")
shuliang=request.form("shuliang")
if material="设备" then
set matu=conn.execute("insert into material_info(consume_id,material_type,total,place,remark,material_time) values("&conid&",'"&material&"',"&dashu&",'"&weizhi&"','"&beizhu&"','"&material_time&"')")
else
set matu=conn.execute("insert into material_info(consume_id,material_type,number,number_unit,total,place,remark,material_time) values("&conid&",'"&material&"',"&dashu&","&zhesuan&","&shuliang&",'"&weizhi&"','"&beizhu&"','"&material_time&"')")
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
  			<td class="table_title">添加结果</td>
  		</tr>
  		<tr>
  			<td align="center">添加成功！</td>
  		</tr>
  	</table>
  </body>
</html>