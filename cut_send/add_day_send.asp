<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
send_date=trim(request("send_date"))
send_amount=trim(request("send_amount"))
suborder_color=trim(request("suborder_color"))
suborder_size=trim(request("suborder_size"))
send_group=trim(request("send_group"))
arrange_no=trim(request("arrange_no"))

suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
send_amount_arr=split(send_amount,",")

if send_date="" then
	errmsg="“发活日期”不能为空，请重新填写！" 
	return_url="input_day_send.asp?arrange_no="&arrange_no&"&send_group="&send_group
	time_out=1
elseif isdate(send_date)=0 then
	errmsg="所填写的日期无效，请重新填写!"
	return_url="input_day_send.asp?arrange_no="&arrange_no&"&send_group="&send_group
	time_out=1
else
  for i=0 to ubound(suborder_color_arr)
    if trim(send_amount_arr(i))<>"" and trim(send_amount_arr(i))<>"0" then
    	set rs3=Server.CreateObject("ADODB.Recordset")
      sql3="select * from day_send_info where arrange_no='"&arrange_no&"' and send_group='"&send_group&"' and send_date='"&send_date&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
      'response.write "select:"&sql3&"<br>"
      rs3.open sql3,conn,1,1
      if not rs3.eof then
      	set rs2=Server.CreateObject("ADODB.Recordset")
        sql2="update day_send_info set send_amount=send_amount+"&cint(trim(send_amount_arr(i)))&" where arrange_no='"&arrange_no&"' and send_group='"&send_group&"' and send_date='"&send_date&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
        'response.write "update:"&sql2&"<br>"
        rs2.open sql2,conn,1,3
        rs2.close
        set rs2=nothing
      else
        no_year=right(year(send_date),2)
        if len(month(send_date))=1 then
        	no_month="0"&month(send_date)
        else
        	no_month=month(send_date)
        end if
        if len(day(send_date))=1 then
        	no_day="0"&day(send_date)
        else
        	no_day=day(send_date)
        end if
        send_no="BT-SC-B-006-"&no_year&no_month&no_day
        set rs=Server.CreateObject("ADODB.Recordset")
        sql="insert into day_send_info (send_date,send_no,send_group,arrange_no,suborder_color,suborder_size,send_amount) values ('"&send_date&"','"&send_no&"','"&send_group&"','"&arrange_no&"','"&trim(suborder_color_arr(i))&"','"&trim(suborder_size_arr(i))&"',"&cint(trim(send_amount_arr(i)))&")"
        'response.write "insert:"&sql&"<br>"
        rs.open sql,conn,1,3
        rs.close
        set rs=nothing
      end if
      rs3.close
      set rs3=nothing
    end if
  next
  errmsg="生产小组“"&send_group&"”的发活数据录入成功！"
	'return_url="show_day_produce.asp?arrange_no="&arrange_no&"&send_group="&send_group
end if
'response.end
if return_url<>"" then
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
  			<td class="table_title">录入结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>
<%else%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body topmargin=0 leftmargin=0>
  	<br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">录入结果</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  	<br>
    <center>
    <input name="input_order" type="button" onclick="MM_goToURL('self','list_arrange.asp');return document.MM_returnValue" value="继续录入">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_day_send.asp?send_date=<%=send_date%>');return document.MM_returnValue" value="查看日发活量">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_cut_stat.asp');return document.MM_returnValue" value="查看完成品统计">
    <br><br>
    </center>
  </body>
</html>
<%end if%>