<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
arrange_no=trim(request("arrange_no"))
arrange_group=trim(request("arrange_group"))
is_del=trim(request("is_del"))

if is_del="取 消" then
  response.redirect "edit_arrange.asp"
  response.end
end if
'停产操作：1.清批日期改为今天；2.删除arrange_amount_info中所有该小组该排产表的纪录，
'然后重新插入day_produce_info中的该小组该排产表的所有记录。
set rs=Server.CreateObject("ADODB.Recordset")
sql="update arrange_group_info set date_finish='"&datevalue(now())&"' where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
rs.open sql,conn,1,3
rs.close
set rs=nothing
set rs1=Server.CreateObject("ADODB.Recordset")
sql1="delete from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
rs1.open sql1,conn,1,3
rs1.close
set rs1=nothing
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="SELECT SUM(day_amount) AS day_amount_sum, suborder_color, suborder_size FROM day_produce_info WHERE (arrange_no = '"&arrange_no&"') AND (day_group = '"&arrange_group&"') GROUP BY suborder_size, suborder_color"
'response.write sql2
rs2.open sql2,conn,1,1
while not rs2.eof
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="insert into arrange_amount_info (arrange_group,arrange_no,suborder_color,suborder_size,arrange_amount) values ('"&arrange_group&"','"&arrange_no&"','"&rs2("suborder_color")&"','"&rs2("suborder_size")&"',"&rs2("day_amount_sum")&")"
  'response.write sql3
  rs3.open sql3,conn,1,3
  rs3.close
  set rs3=nothing
  rs2.movenext
wend
rs2.close
set rs2=nothing
errmsg="生产小组“"&arrange_group&"”的排产表“"&arrange_no&"”停产成功！"
time_out=0
return_url="edit_arrange.asp"
'response.end
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
  			<td class="table_title">操作结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>