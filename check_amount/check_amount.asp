<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<%
order=request("order")
consume_id=request("conid")
consume_type=request("material")
jiagjs=request("dingdan")
xuysl=request("xuyao")
set checkb=conn.execute("select * from checkamount_info where consume_id='"&consume_id&"' and consume_type='"&consume_type&"'")

time_out=0
if not checkb.eof then
sql="update checkamount_info set jiagjs='"&jiagjs&"',xuysl='"&xuysl&"' where consume_id='"&consume_id&"' and consume_type='"&consume_type&"'"
set rs=conn.execute(sql)
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=ifc_checkamount.asp?conid=<%=order%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">修改结果</td>
  		</tr>
  		<tr>
  			<td align="center">修改成功！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
else
sql="insert into checkamount_info(consume_id,consume_type,jiagjs,xuysl)values('"&consume_id&"','"&consume_type&"','"&jiagjs&"','"&xuysl&"')"
set rs=conn.execute(sql)

%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=ifc_checkamount.asp?conid=<%=order%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">核产结果</td>
  		</tr>
  		<tr>
  			<td align="center">核产成功！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
end if
o="0"
i="0"
f="0"
e="0"

set ssout=conn.execute("select * from unitconsume_out where order_no='"&order&"'")
do while not ssout.eof
   set sscho=conn.execute("select * from checkamount_info where consume_id='"&ssout("consume_id")&"' and consume_type='面料'")
   if sscho.eof then
     o="1"
     exit do
   end if
   ssout.movenext
loop
set ssin=conn.execute("select * from unitconsume_in where order_no='"&order&"'")
do while not ssin.eof
   set sschi=conn.execute("select * from checkamount_info where consume_id='"&ssin("consume_id")&"' and consume_type='里料'")
   if sschi.eof then
     i="1"
     exit do
   end if
   ssin.movenext
loop
set ssf=conn.execute("select * from unitconsume_other where order_no='"&order&"'")
do while not ssf.eof
   set sschf=conn.execute("select * from checkamount_info where consume_id='"&ssf("consume_id")&"' and consume_type='辅料'")
   if sschf.eof then
     f="1"
     exit do
   end if
   ssf.movenext
loop
set sse=conn.execute("select * from unitconsume_equipment where order_no='"&order&"'")
do while not sse.eof
   set ssche=conn.execute("select * from checkamount_info where consume_id='"&sse("consume_id")&"' and consume_type='设备'")
   if ssche.eof then
     e="1"
     exit do
   end if
   sse.movenext
loop

if o="0" and i="0" and f="0" and e="0" then
   set orderstate=conn.execute("update order_info set state='核产完毕' where order_no='"&order&"'")
end if
%>
