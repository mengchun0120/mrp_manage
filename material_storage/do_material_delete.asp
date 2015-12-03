<!--#include file=../inc/conn.asp-->
<%conid=request.form("conid")
  order=request("order")
	set dele=conn.execute("delete from material_info where material_id="&conid&"")
  return_url="ifc_yuanliaoruku.asp?conid="&order
  time_out=0
  %>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=<%=return_url%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">删除结果</td>
  		</tr>
  		<tr>
  			<td align="center">删除成功！</td>
  		</tr>
  	</table>
  </body>
</html>