<!--#include file="../inc/conn.asp"-->
<%
time_out=0
order=request("conid")
'kuanid=request("kuanid")
set s=conn.execute("update order_info set state='�������',consume_date='"&now()&"' where order_no='"&order&"'")
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
  			<td class="table_title">���</td>
  		</tr>
  		<tr>
  			<td align="center">�˶������ļ�����ϣ�</td>
  		</tr>
  	</table>
  </body>
</html>