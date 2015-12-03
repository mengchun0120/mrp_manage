<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
date_start=trim(request("date_start"))
date_finish=trim(request("date_finish"))
work_time=trim(request("work_time"))
arrange_amount=trim(request("arrange_amount"))
suborder_color=trim(request("suborder_color"))
suborder_size=trim(request("suborder_size"))
notify_no=trim(request("notify_no"))
arrange_group=trim(request("arrange_group"))
arrange_no=trim(request("arrange_no"))
design_no=trim(request("design_no"))
standard_workload=trim(request("standard_workload"))

suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
arrange_amount_arr=split(arrange_amount,",")

is_insert=0
'得到本次该小组要排产的数量总合
for i=0 to ubound(suborder_color_arr)
  is_insert=is_insert+cint(trim(arrange_amount_arr(i)))
next
'数量等于0时，不写入数据库
if is_insert<>0 then
	set rs5=Server.CreateObject("ADODB.Recordset")
  sql5="select * from arrange_group_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
  'response.write sql5&"<br>"
  rs5.open sql5,conn,1,1
  if not rs5.eof then
  	set rs6=Server.CreateObject("ADODB.Recordset")
    sql6="update arrange_group_info set date_start='"&date_start&"', date_finish='"&date_finish&"', work_time="&cint(work_time)&" where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
    'response.write sql6
    rs6.open sql6,conn,1,3
    rs6.close
    set rs6=nothing
  else
    set rs0=Server.CreateObject("ADODB.Recordset")
    sql0="insert into arrange_group_info (arrange_group,arrange_no,date_start,date_finish,work_time) values ('"&arrange_group&"','"&arrange_no&"','"&date_start&"','"&date_finish&"',"&work_time&")"
    'response.write sql0
    rs0.open sql0,conn,1,3
    rs0.close
    set rs0=nothing
  end if
  rs5.close
  set rs5=nothing
end if
'response.end
'response.write ubound(suborder_color_arr)&"<br>"
for i=0 to ubound(suborder_color_arr)
  if trim(arrange_amount_arr(i))<>"" and trim(arrange_amount_arr(i))<>"0" then
  	set rs3=Server.CreateObject("ADODB.Recordset")
    sql3="select * from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
    rs3.open sql3,conn,1,1
    if not rs3.eof then
    	set rs2=Server.CreateObject("ADODB.Recordset")
      sql2="update arrange_amount_info set arrange_amount=arrange_amount+"&cint(trim(arrange_amount_arr(i)))&" where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
      rs2.open sql2,conn,1,3
      rs2.close
      set rs2=nothing
    else
      set rs=Server.CreateObject("ADODB.Recordset")
      sql="insert into arrange_amount_info (arrange_group,arrange_no,suborder_color,suborder_size,arrange_amount) values ('"&arrange_group&"','"&arrange_no&"','"&trim(suborder_color_arr(i))&"','"&trim(suborder_size_arr(i))&"',"&cint(trim(arrange_amount_arr(i)))&")"
      rs.open sql,conn,1,3
      rs.close
      set rs=nothing
    end if
    rs3.close
    set rs3=nothing
  end if
next
'response.end
%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body topmargin=0 leftmargin=0>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=6>生产小组“<%=arrange_group%>”当前排产结果</td>
  </tr>
  <tr>
  	<th>开始日期：</th><td align=center><%=date_start%></td>
  	<th>清批日期：</th><td align=center><%=date_finish%></td>
  	<th>每日工作时长：</th><td align=center><%=work_time%>小时</td>
  </tr>
</table>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  'title_span=rs3.recordcount
%>
<table width="100%" cellspacing=1>
	<tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尺码<br>数量<br>色号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<%
   while not rs3.eof
  	  set rs_inlen=Server.CreateObject("ADODB.Recordset")
      sql_inlen="select top 1 suborder_inlen from suborder_info where order_no=(select top 1 order_no from notify_produce_info where notify_no='"&notify_no&"')"
      rs_inlen.open sql_inlen,conn,1,1
  	  response.write "<th>"
  	  response.write rs3("suborder_size")
  	  if rs_inlen("suborder_inlen")<>0 then
  	  	response.write " / "&rs_inlen("suborder_inlen")
  	  end if
  	  response.write "</th>"
  	  rs_inlen.close
  	  set rs_inlen=nothing
  	  rs3.movenext
   wend
  	response.write "<th>合计</th></tr>"
  	rs3.movefirst
  	alladdup=0
  	while not rs2.eof
  	  response.write "<tr><th>"&rs2("suborder_color")&"</th>"
  	  rs3.movefirst
  	  addup=0
  	  while not rs3.eof
  	    set rs4=Server.CreateObject("ADODB.Recordset")
        sql4="select arrange_amount from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
        rs4.open sql4,conn,1,1
        'response.write "|"&trim(rs4("produce_amount_sum"))&"|"&sql4
        if rs4.eof then
        	response.write "<td align=center>&nbsp;</td>"
        else
        	tmp=0
        	while not rs4.eof
        	  addup=addup+cint(rs4("arrange_amount"))
        	  tmp=tmp+cint(rs4("arrange_amount"))
        	  rs4.movenext
        	wend
          response.write "<td align=center>"&tmp&"</td>"
        end if
  	    rs4.close
  	    set rs4=nothing
  	    rs3.movenext
  	  wend
  	  response.write "<td align=center>"&addup&"</td></tr>"
  	  alladdup=alladdup+addup
  	  rs2.movenext
  	wend
  	rs2.close
  	set rs2=nothing
  	rs3.close
  	set rs3=nothing
  end if
%>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<%end if%>
<br>
<center>
  <input name="input_order" type="button" onclick="MM_goToURL('self','arrange_finish.asp?arrange_no=<%=arrange_no%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="完成排产">
  <input name="input_order" type="button" onclick="MM_goToURL('self','list_group.asp?notify_no=<%=notify_no%>&arrange_no=<%=arrange_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="继续排产">
</center>
  </body>
</html>