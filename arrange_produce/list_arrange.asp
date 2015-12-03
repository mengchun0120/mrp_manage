<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next

arrange_no=trim(request("arrange_no"))
arrange_group=trim(request("arrange_group"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title"  colspan=6>其选择要查询的排产表</td>
  </tr>
  <tr>
  	<th>排产表号</th><th>通知单号</th><th>款号</th><th>排产人</th><th>排产日期</th><th>操作</th>
  </tr>
  <%
  set rs0=Server.CreateObject("ADODB.Recordset")
  sql0="select * from arrange_info where state='录入完成' order by arrange_no desc"
  rs0.open sql0,conn,1,1
  while not rs0.eof
  %>
  <tr>
  	<td align=center><%=rs0("arrange_no")%></td>
  	<td align=center><%=rs0("notify_no")%></td>
  	<td align=center><%=rs0("design_no")%></td>
  	<td align=center><%=rs0("lister")%></td>
  	<td align=center><%=rs0("date_created")%></td>
  	<th><input name="input_order" type="button" onclick="MM_goToURL('self','list_arrange.asp?arrange_no=<%=rs0("arrange_no")%>');return document.MM_returnValue" value="查看详细"></th>
  </tr>
  <%
    rs0.movenext
  wend
  rs0.close
  set rs0=nothing
  %>
</table>
<%if arrange_no<>"" then%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title"  colspan=8>排产表“<%=arrange_no%>”详细信息</td>
  </tr>
  <%
  set rs8=Server.CreateObject("ADODB.Recordset")
  sql8="select * from arrange_info where arrange_no='"&arrange_no&"'"
  rs8.open sql8,conn,1,1
  %>
  <tr>
  	<th>通知单号：</th><td align=center><%=rs8("notify_no")%></td><th>款号：</th><td align=center><%=rs8("design_no")%></td><th>排产人：</th><td align=center><%=rs8("lister")%></td><th>排产日期：</th><td align=center><%=rs8("date_created")%></td>
  </tr>
</table>
<table width="100%" cellspacing=1>
	<tr>
    <th>序号</th><th>小组名称</th><th>人数</th><th>生产能力</th><th>开始日期</th><th>清批日期</th><th>每日工作时长</th><th>总数</th><th>任务负载</th><th>操作</th>
  </tr>
  <%
  serial_no=0
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="select * from arrange_group_info where arrange_no='"&arrange_no&"'"
  rs.open sql,conn,1,1
  while not rs.eof
    serial_no=serial_no+1
  %>
    <th><%=serial_no%></th>
    <td align=center><%=rs("arrange_group")%></td>
    <td align=center>
  	<%
  	'小组人数
  	set rs2=Server.CreateObject("ADODB.Recordset")
    sql2="select * from worker_info where group_id= (select group_id from group_info where group_name='"&rs("arrange_group")&"')"
    rs2.open sql2,conn,1,1
    response.write rs2.recordcount
    rs2.close
    set rs2=nothing
  	%></td>
  	<td align=center>
  	<%
  	'计算小组生产能力
  	throughput=0
  	set rs7=Server.CreateObject("ADODB.Recordset")
    sql7="SELECT SUM(day_amount) AS yesterday_amount_sum, arrange_no FROM day_produce_info WHERE (day_date = '"&dateadd("d",-1,datevalue(now()))&"') AND (day_group = '"&rs("arrange_group")&"') GROUP BY arrange_no"
    'response.write sql7
    rs7.open sql7,conn,1,1
    while not rs7.eof
      set rs9=Server.CreateObject("ADODB.Recordset")
      sql9="select man_hour from item_info where design_no=(select design_no from arrange_info where arrange_no='"&rs7("arrange_no")&"')"
      'response.write sql9&"<br>"
      rs9.open sql9,conn,1,1
      throughput=throughput+cint(rs7("yesterday_amount_sum"))*cint(rs9("man_hour"))/3600
      'response.write rs7("yesterday_amount_sum")&"|"&rs7("arrange_no")&"|"&rs9("man_hour")&"|"
      rs9.close
      set rs9=nothing
      rs7.movenext
    wend
    rs7.close
    set rs7=nothing
    throughput=round(throughput)
    if throughput=0 then
    	throughput="无"
    end if
    response.write throughput
  	%></td>
  	<td align=center><%=rs("date_start")%></td>
  	<td align=center><%=rs("date_finish")%></td>
  	<td align=center><%=rs("work_time")%> 小时</td>
  	<td align=center>
  	<%
  	set rs3=Server.CreateObject("ADODB.Recordset")
    sql3="select sum(arrange_amount) as arrange_amount_sum from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&rs("arrange_group")&"'"
    rs3.open sql3,conn,1,1
    response.write rs3("arrange_amount_sum")
    rs3.close
    set rs3=nothing
  	%></td>
  	<td align=center>
  	<%
  	'计算小组任务负载
  	this_arrange_amount_sum=0
    '得到该小组该排产表已经安排的排产量
    set rs10=Server.CreateObject("ADODB.Recordset")
    sql10="select sum(arrange_amount) as arrange_amount_sum from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&rs("arrange_group")&"'"
    rs10.open sql10,conn,1,1
    this_arrange_amount_sum=this_arrange_amount_sum+cint(rs10("arrange_amount_sum"))
    'response.write "this_arrange_amount_sum:"&this_arrange_amount_sum&"<br>"
    rs10.close
    set rs10=nothing
    set rs11=Server.CreateObject("ADODB.Recordset")
    sql1="select man_hour from item_info where design_no=(select design_no from arrange_info where arrange_no='"&arrange_no&"')"
    rs11.open sql1,conn,1,1
    man_hour=cint(rs11("man_hour"))
    'response.write "man_hour:"&man_hour&"<br>"
    'response.write "sql11:"&sql11&"<br>"
    rs11.close
    set rs11=nothing
  	yesterday_all_hour=0
    set rs13=Server.CreateObject("ADODB.Recordset")
    sql13="SELECT SUM(day_amount) AS yesterday_amount_sum, arrange_no FROM day_produce_info WHERE (day_date = '"&dateadd("d",-1,datevalue(now()))&"') AND (day_group = '"&rs("arrange_group")&"') GROUP BY arrange_no"
    'response.write sql13&"<br>"
    rs13.open sql13,conn,1,1
    while not rs13.eof
      set rs14=Server.CreateObject("ADODB.Recordset")
      sql14="select man_hour from item_info where design_no=(select design_no from arrange_info where arrange_no='"&rs13("arrange_no")&"')"
      'response.write sql14&"<br>"
      rs14.open sql14,conn,1,1
      yesterday_all_hour=yesterday_all_hour+cint(rs13("yesterday_amount_sum"))*cint(rs14("man_hour"))
      'response.write rs13("yesterday_amount_sum")&"|"&rs13("arrange_no")&"|"&rs14("man_hour")&"|"
      rs14.close
      set rs14=nothing
      rs13.movenext
    wend
    rs13.close
    set rs13=nothing
    fact_workload=(this_arrange_amount_sum*man_hour)/(datediff("d",rs("date_start"),rs("date_finish"))+1)/yesterday_all_hour
  	%><%=round(fact_workload*100)%>%</td>
  	<th>
  	<input name="input_order" type="button" onclick="MM_goToURL('self','list_arrange.asp?arrange_no=<%=arrange_no%>&arrange_group=<%=rs("arrange_group")%>');return document.MM_returnValue" value="查看详细">
  </th></tr>
  <%
    rs.movenext
  wend
  rs.close
  set rs=nothing
  %>
</table>

<%if arrange_group<>"" then
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=rs3.recordcount
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=<%=title_span+2%>>生产小组“<%=arrange_group%>”排产详细</td>
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
<%end if
end if
end if
%>

</body>
</html>