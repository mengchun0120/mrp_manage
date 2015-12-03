<!--#include file="../inc/conn.asp"-->
<%
time_out=0
order=request("conid")
'kuanid=request("kuanid")
set s=conn.execute("update order_info set state='单耗完毕',consume_date='"&now()&"' where order_no='"&order&"'")
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=show_item.asp?item_id=<%=session("itemk")%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">结果</td>
  		</tr>
  		<tr>
  			<td align="center">此订单单耗计算完毕！</td>
  		</tr>
  	</table>
  </body>
</html>