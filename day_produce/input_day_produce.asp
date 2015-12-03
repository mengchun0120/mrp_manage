<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

arrange_no=trim(request("arrange_no"))
day_group=trim(request("day_group"))
notify_no=trim(request("notify_no"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=rs3.recordcount
%>
<table width="100%" cellspacing=1>
	<form action="add_day_produce.asp" method=post target="mainFrame">
	<tr>
  	<td class="table_title" colspan=<%=title_span+2%>>生产小组“<%=day_group%>”日产</td>
  </tr>
	<tr>
  	<th>日产日期：</th>
  	<td colspan=<%=title_span+1%>>
  		<select name="day_date">
  		<%
  		set rs7=Server.CreateObject("ADODB.Recordset")
      sql7="select date_start,date_finish from arrange_group_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"'"
      rs7.open sql7,conn,1,1
      for i=0 to datediff("d",rs7("date_start"),rs7("date_finish"))
  		%>
        <option <%if dateadd("d",i,rs7("date_start"))=datevalue(now()) then%>selected<%end if%>><%=dateadd("d",i,rs7("date_start"))%></option>
      <%
      next
      rs7.close
      set rs7=nothing
      %>
      </select>
  	</td>
  </tr>
	<tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尺码<br>数量<br>色号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<%
   while not rs3.eof
  	  set rs_inlen=Server.CreateObject("ADODB.Recordset")
      sql_inlen="select top 1 suborder_inlen from suborder_info where order_no=(select top 1 order_no from notify_produce_info where notify_no=(select top 1 notify_no from arrange_info where arrange_no='"&arrange_no&"'))"
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
        sql4="select arrange_amount from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
        rs4.open sql4,conn,1,1
        'response.write "|"&trim(rs4("produce_amount_sum"))&"|"&sql4
        if rs4.eof then
        	response.write "<td align=center>&nbsp;</td>"
        else
        	arrange_amount_sum=0
        	while not rs4.eof
        	  addup=addup+cint(rs4("arrange_amount"))
        	  arrange_amount_sum=arrange_amount_sum+cint(rs4("arrange_amount"))
        	  rs4.movenext
        	wend
        	set rs5=Server.CreateObject("ADODB.Recordset")
          sql5="select sum(day_amount) as day_amount_sum from day_produce_info where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
          rs5.open sql5,conn,1,1
          day_amount_sum=0
          day_amount_sum=day_amount_sum+cint(rs5("day_amount_sum"))
          addup=addup-day_amount_sum
          response.write "<td align=center>"&arrange_amount_sum&"-"&day_amount_sum&"="&arrange_amount_sum-day_amount_sum
          %>
          <input type=text size=5 name="day_amount">
          <input type=hidden name="suborder_color" value="<%=rs2("suborder_color")%>">
          <input type=hidden name="suborder_size" value="<%=rs3("suborder_size")%>"></td>
          <%
          rs5.close
  	      set rs5=nothing
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
  set rs6=Server.CreateObject("ADODB.Recordset")
  sql6="select * from notify_info where notify_no=(select notify_no from arrange_info where arrange_no='"&arrange_no&"')"
  'response.write sql6
  rs6.open sql6,conn,1,1
%>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan="<%=title_span+1%>"><%=trans_code(rs6("remark"))%></td>
  </tr>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<%end if%>
<br>
<center>
<input type=hidden name="day_group" value="<%=day_group%>">
<input type=hidden name="arrange_no" value="<%=arrange_no%>">
<input type=hidden name="notify_no" value="<%=notify_no%>">
<input name="affirm_order" type="submit" value="确认输入">
<input name="affirm_order" type="reset" value="重新输入">
<input name="input_order" type="button" onclick="MM_goToURL('self','list_group.asp');return document.MM_returnValue" value="返 回">
</form>
<br><br>
</center>
</body>
</html>