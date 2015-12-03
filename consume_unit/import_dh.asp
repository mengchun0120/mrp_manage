<!--#include file=../inc/conn.asp-->
<%
  neworder=request.form("neworder")
	oldorder=request.form("conid")
	
	selsql="select * from unitconsume_out where order_no='"&oldorder&"'"
  set rss=conn.execute(selsql)
  while not rss.eof
     set rssin=conn.execute("insert into unitconsume_out values('"&neworder&"','"&rss("consume_name")&"','"&rss("consume_color")&"','"&rss("consume_chengf")&"','"&rss("consume_fuk")&"','"&rss("consume_danw")&"','"&rss("consume_kegyl")&"','"&rss("consume_shijyl")&"','"&rss("consume_sunh")&"','"&rss("consume_caijyl")&"','"&rss("consume_beiz")&"')")
     rss.movenext
  wend
  
  llsql="select * from unitconsume_in where order_no='"&oldorder&"'"
  set rsl=conn.execute(llsql)
  while not rsl.eof
     set rslin=conn.execute("insert into unitconsume_in values('"&neworder&"','"&rsl("consume_name")&"','"&rsl("consume_color")&"','"&rsl("consume_chengf")&"','"&rsl("consume_fuk")&"','"&rsl("consume_danw")&"','"&rsl("consume_kegyl")&"','"&rsl("consume_shijyl")&"','"&rsl("consume_sunh")&"','"&rsl("consume_caijyl")&"','"&rsl("consume_beiz")&"')")
     rsl.movenext
  wend
  flsql="select * from unitconsume_other where order_no='"&oldorder&"'"
  set rsf=conn.execute(flsql)
  while not rsf.eof
     set rsfin=conn.execute("insert into unitconsume_other values('"&neworder&"','"&rsf("consume_name")&"','"&rsf("consume_chengf")&"','"&rsf("consume_fuk")&"','"&rsf("consume_danw")&"','"&rsf("consume_danh")&"','"&rsf("consume_beiz")&"')")
     rsf.movenext
  wend
  sbsql="select * from unitconsume_equipment where order_no='"&oldorder&"'"
  set rsb=conn.execute(sbsql)
	while not rsb.eof
     set rsbin=conn.execute("insert into unitconsume_equipment values('"&neworder&"','"&rsb("consume_name")&"','"&rsb("consume_guig")&"','"&rsb("consume_shul")&"','"&rsb("consume_beiz")&"')")
     rsb.movenext
  wend
  time_out=0
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=ifc_dhjs.asp?conid=<%=neworder%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">导入结果</td>
  		</tr>
  		<tr>
  			<td align="center">导入成功！</td>
  		</tr>
  	</table>
  </body>
</html>