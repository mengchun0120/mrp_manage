<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
arrange_no=trim(request("arrange_no"))
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
  	<td class="table_title" colspan="13">缝纫车间小组生产安排表（当前日期：<%=datevalue(now())%>）</td>
  </tr>
  <tr>
    <th>序号</th><th>操作</th><th>小组</th><th>人数</th><th>生产能力</th><th>排产表号</th><th>通知单号</th><th>款号</th><th>清批日期</th><th>总数</th><th>完成比</th><th>预计完成日期</th><th>排产人</th>
  </tr>
  <%
  serial_no=0
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="select * from group_info order by group_name"
  rs.open sql,conn,1,1
  while not rs.eof
    serial_no=serial_no+1
    set rs3=Server.CreateObject("ADODB.Recordset")
    sql3="select * from arrange_group_info where arrange_group='"&rs("group_name")&"'"
    rs3.open sql3,conn,1,1
    rowspan=rs3.recordcount
    if rowspan=0 then
    	rowspan=1
    end if
    'rs3.close
    'set rs3=nothing
  %>
  <tr>
  	<th rowspan=<%=rowspan%>><%=serial_no%></th>
  	<th rowspan=<%=rowspan%>>
  	<%
  	'set rs6=Server.CreateObject("ADODB.Recordset")
    'sql6="select * from arrange_group_info where arrange_group='"&rs("group_name")&"' and arrange_no='"&arrange_no&"'"
    'rs6.open sql6,conn,1,1
    '在同一个排产表中，同一小组不能重复排产
    'if rs6.eof then
  	%>
  		<input name="input_arrange" type="button" onclick="MM_goToURL('self','input_arrange.asp?arrange_no=<%=arrange_no%>&arrange_group=<%=rs("group_name")%>&design_no=<%=design_no%>&notify_no=<%=notify_no%>');return document.MM_returnValue" value="选择">
    <%'else%>
      <!--已排产-->
    <%
    'end if
    'rs6.close
    'set rs6=nothing
    %>
  	</th>
  	<td align=center rowspan=<%=rowspan%>><%=rs("group_name")%></td>
  	<td align=center rowspan=<%=rowspan%>>
  	<%
  	'小组人数
  	set rs2=Server.CreateObject("ADODB.Recordset")
    sql2="select * from worker_info where group_id="&rs("group_id")
    rs2.open sql2,conn,1,1
    response.write rs2.recordcount
    rs2.close
    set rs2=nothing
  	%></td>
  	<td align=center rowspan=<%=rowspan%>>
  	<%
  	'计算小组生产能力
  	throughput=0
  	set rs8=Server.CreateObject("ADODB.Recordset")
    sql8="SELECT SUM(day_amount) AS yesterday_amount_sum, arrange_no FROM day_produce_info WHERE (day_date = '"&dateadd("d",-1,datevalue(now()))&"') AND (day_group = '"&rs("group_name")&"') GROUP BY arrange_no"
    'response.write sql8
    rs8.open sql8,conn,1,1
    while not rs8.eof
      set rs9=Server.CreateObject("ADODB.Recordset")
      sql9="select man_hour from item_info where design_no=(select design_no from arrange_info where arrange_no='"&rs8("arrange_no")&"')"
      'response.write sql9&"<br>"
      rs9.open sql9,conn,1,1
      throughput=throughput+cint(rs8("yesterday_amount_sum"))*cint(rs9("man_hour"))/3600
      'response.write rs8("yesterday_amount_sum")&"|"&rs8("arrange_no")&"|"&rs9("man_hour")&"|"
      rs9.close
      set rs9=nothing
      rs8.movenext
    wend
    rs8.close
    set rs8=nothing
    throughput=round(throughput)
    if throughput=0 then
    	throughput="无"
    end if
    response.write throughput
  	%></td>
  	<%
  	if rs3.recordcount=0 then
  	%>
  	  <td align=center>无</td><td align=center>无</td><td align=center>无</td><td align=center>无</td><td align=center>0</td><td align=center>0%</td><td align=center>&nbsp;</td><td align=center>无</td></tr>
  	<%
    else
  	  tr_flag=0
  	  while not rs3.eof
  	    tr_flag=tr_flag+1
  	    set rs4=Server.CreateObject("ADODB.Recordset")
        sql4="select * from arrange_info where arrange_no='"&rs3("arrange_no")&"' order by arrange_no desc"
        rs4.open sql4,conn,1,1
  	%>
  	    <td align=center><%=rs4("arrange_no")%></td>
  	    <td align=center><%=rs4("notify_no")%></td>
  	    <td align=center><%=rs4("design_no")%></td>
  	    <td align=center><%=rs3("date_finish")%></td>
  	    <td align=center>
  	    <%
  	    '总数
  	    set rs5=Server.CreateObject("ADODB.Recordset")
        sql5="select sum(arrange_amount) as arrange_amount_sum from arrange_amount_info where arrange_no='"&rs3("arrange_no")&"' and arrange_group='"&rs3("arrange_group")&"'"
        rs5.open sql5,conn,1,1
        arrange_amount_sum=cint(rs5("arrange_amount_sum"))
        response.write arrange_amount_sum
        rs5.close
        set rs5=nothing
  	    %>
  	    </td>
  	    <td align=center>
  	    <%
  	    '完成比
  	    set rs10=Server.CreateObject("ADODB.Recordset")
        sql10="select sum(day_amount) as day_amount_sum from day_produce_info where arrange_no='"&rs3("arrange_no")&"' and day_group='"&rs3("arrange_group")&"'"
        rs10.open sql10,conn,1,1
        day_amount_sum=0
        day_amount_sum=day_amount_sum+cint(rs10("day_amount_sum"))
        response.write round(day_amount_sum/arrange_amount_sum*100)
  	    %>%</td>
  	    <td align=center>
  	    <%
  	    '预计完成天数
  	    if datediff("d",datevalue(now()),rs3("date_finish"))<0 then
  	      response.write "已过清批期"
  	    elseif day_amount_sum=arrange_amount_sum then
  	    	response.write "任务已完成"
  	    else
  	    	response.write dateadd("d",round(arrange_amount_sum/(day_amount_sum/datediff("d",rs3("date_start"),datevalue(now())))),rs3("date_start"))
  	    end if
  	    'response.write dateadd("d",int(100/(50/datediff("d","2006-3-10","2006-3-14"))),"2006-3-10")
  	    %>
  	    </td>
  	    <td align=center><%=rs4("lister")%></td></tr>
  	<%
  	    if tr_flag<rs3.recordcount then
  	  	  response.write "<tr>"
  	    end if
  	    rs4.close
  	    set rs4=nothing
  	    rs3.movenext
      wend
      rs3.close
      set rs3=nothing
    end if
  	%>
  <%
    rs.movenext
  wend
  'rs循环结束
  rs.close
  set rs=nothing
  %>
</table>
<br>
<%
set rs7=Server.CreateObject("ADODB.Recordset")
sql7="select * from arrange_group_info where arrange_no='"&arrange_no&"'"
rs7.open sql7,conn,1,1
if not rs7.eof then
%>
<center>
  <input name="input_order" type="button" onclick="MM_goToURL('self','arrange_finish.asp?arrange_no=<%=arrange_no%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="完成排产">
</center><br><br>
<%
end if
rs7.close
set rs7=nothing
%>
</body>
</html>