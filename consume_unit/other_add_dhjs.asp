<!--#include file=../inc/conn.asp-->
<%
  order=request.form("order")
	mc=request.form("mc")
	cf=request.form("cf")
	fk=request.form("fk")
	dw=request.form("dw")
	cj=request.form("cj")
	bz=request.form("bz")
	'response.write mc&" "&cf&" "&fk&" "&dw&" "&cj&" "&bz
  insql="insert into unitconsume_other(order_no,consume_name,consume_chengf,consume_fuk,consume_danw,consume_danh,consume_beiz) values ('"&order&"','"&mc&"','"&cf&"','"&fk&"','"&dw&"',"&cj&",'"&bz&"')"
  conn.execute(insql)
  time_out=0
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