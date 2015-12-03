<!--#include file=../inc/conn.asp-->
<%
  time_out=0
  order=request.form("order")
	mc=request.form("mc")
	cf=request.form("gg")
	fk=request.form("sl")
	bz=request.form("bz")
  insql="insert into unitconsume_equipment(order_no,consume_name,consume_guig,consume_shul,consume_beiz) values ('"&order&"','"&mc&"','"&cf&"','"&fk&"','"&bz&"')"
  conn.execute(insql)
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=ifc_dhjs.asp?conid=<%=order%>'>
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