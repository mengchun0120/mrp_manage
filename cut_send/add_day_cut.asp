<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
cut_date=trim(request("cut_date"))
cut_amount=trim(request("cut_amount"))
suborder_color=trim(request("suborder_color"))
suborder_size=trim(request("suborder_size"))
notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))

suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
cut_amount_arr=split(cut_amount,",")

if cut_date="" then
	errmsg="“日期”不能为空，请重新填写！" 
	return_url="input_day_cut.asp?notify_no="&notify_no&"&design_no="&design_no
	time_out=1
elseif isdate(cut_date)=0 then
	errmsg="所填写的日期无效，请重新填写!"
	return_url="input_day_cut.asp?notify_no="&notify_no&"&design_no="&design_no
	time_out=1
else
  for i=0 to ubound(suborder_color_arr)
    if trim(cut_amount_arr(i))<>"" and trim(cut_amount_arr(i))<>"0" then
    	set rs3=Server.CreateObject("ADODB.Recordset")
      sql3="select * from day_cut_info where notify_no='"&notify_no&"' and cut_date='"&cut_date&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
      rs3.open sql3,conn,1,1
      if not rs3.eof then
      	set rs2=Server.CreateObject("ADODB.Recordset")
        sql2="update day_cut_info set cut_amount=cut_amount+"&cint(trim(cut_amount_arr(i)))&" where notify_no='"&notify_no&"' and cut_date='"&cut_date&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
        rs2.open sql2,conn,1,3
        rs2.close
        set rs2=nothing
      else
        no_year=right(year(cut_date),2)
        if len(month(cut_date))=1 then
        	no_month="0"&month(cut_date)
        else
        	no_month=month(cut_date)
        end if
        if len(day(cut_date))=1 then
        	no_day="0"&day(cut_date)
        else
        	no_day=day(cut_date)
        end if
        cut_no="BT-SC-B-005-"&no_year&no_month&no_day
        set rs=Server.CreateObject("ADODB.Recordset")
        sql="insert into day_cut_info (cut_date,cut_no,notify_no,suborder_color,suborder_size,cut_amount,design_no) values ('"&cut_date&"','"&cut_no&"','"&notify_no&"','"&trim(suborder_color_arr(i))&"','"&trim(suborder_size_arr(i))&"',"&cint(trim(cut_amount_arr(i)))&",'"&design_no&"')"
        rs.open sql,conn,1,3
        rs.close
        set rs=nothing
      end if
      rs3.close
      set rs3=nothing
    end if
  next
  errmsg="生产通知单“"&notify_no&"”的日裁剪数据录入成功！"
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
    <input name="input_order" type="button" onclick="MM_goToURL('self','list_notify.asp');return document.MM_returnValue" value="继续录入">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_day_cut.asp?cut_date=<%=cut_date%>');return document.MM_returnValue" value="查看日裁剪量">
    <input name="input_order" type="button" onclick="MM_goToURL('self','show_cut_stat.asp');return document.MM_returnValue" value="查看完成品统计">
    <br><br>
    </center>
  </body>
</html>
<%end if%>