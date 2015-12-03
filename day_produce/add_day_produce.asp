<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
day_date=trim(request("day_date"))
day_amount=trim(request("day_amount"))
suborder_color=trim(request("suborder_color"))
suborder_size=trim(request("suborder_size"))
day_group=trim(request("day_group"))
arrange_no=trim(request("arrange_no"))
notify_no=trim(request("notify_no"))

suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
day_amount_arr=split(day_amount,",")

if day_date="" then
	errmsg="“日产日期”不能为空，请重新填写！" 
	return_url="input_day_produce.asp?arrange_no="&arrange_no&"&day_group="&day_group
	time_out=1
elseif isdate(day_date)=0 then
	errmsg="所填写的日期无效，请重新填写!"
	return_url="input_day_produce.asp?arrange_no="&arrange_no&"&day_group="&day_group
	time_out=1
else
  for i=0 to ubound(suborder_color_arr)
    if trim(day_amount_arr(i))<>"" and trim(day_amount_arr(i))<>"0" then
      set rs3=Server.CreateObject("ADODB.Recordset")
      sql3="select * from day_produce_info where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and day_date='"&day_date&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
      rs3.open sql3,conn,1,1
      if not rs3.eof then
      	set rs2=Server.CreateObject("ADODB.Recordset")
        sql2="update day_produce_info set day_amount=day_amount+"&cint(trim(day_amount_arr(i)))&" where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and day_date='"&day_date&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
        rs2.open sql2,conn,1,3
        rs2.close
        set rs2=nothing
      else
        no_year=right(year(day_date),2)
        if len(month(day_date))=1 then
        	no_month="0"&month(day_date)
        else
        	no_month=month(day_date)
        end if
        if len(day(day_date))=1 then
        	no_day="0"&day(day_date)
        else
        	no_day=day(day_date)
        end if
        day_no="BT-SC-B-004-"&no_year&no_month&no_day
        set rs=Server.CreateObject("ADODB.Recordset")
        sql="insert into day_produce_info (day_date,day_no,day_group,notify_no,arrange_no,suborder_color,suborder_size,day_amount) values ('"&day_date&"','"&day_no&"','"&day_group&"','"&notify_no&"','"&arrange_no&"','"&trim(suborder_color_arr(i))&"','"&trim(suborder_size_arr(i))&"',"&cint(trim(day_amount_arr(i)))&")"
        rs.open sql,conn,1,3
        rs.close
        set rs=nothing
      end if
      rs3.close
      set rs3=nothing
    end if
  next
  errmsg="生产小组“"&day_group&"”的日产数据录入成功！"
	'return_url="show_day_produce.asp?arrange_no="&arrange_no&"&day_group="&day_group
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
    <input name="input_order" type="button" onclick="MM_goToURL('self','list_group.asp');return document.MM_returnValue" value="继续录入">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_day_produce.asp?arrange_no=<%=arrange_no%>&day_group=<%=day_group%>');return document.MM_returnValue" value="录入完成">
    <br><br>
    </center>
  </body>
</html>
<%end if%>