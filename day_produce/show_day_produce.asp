<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next
query_date=trim(request("query_date"))
if query_date="" or isdate(query_date)=0 then
	query_date=datevalue(now())
end if
day_group=trim(request("day_group"))
arrange_no=trim(request("arrange_no"))
query_mode=trim(request("query_mode"))
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
  	<td class="table_title" colspan=2>查询模式1：查看所有小组当日产量</td>
  </tr>
  <form action="show_day_produce.asp" method=post target="mainFrame">
  <tr>
  	<th width="120">输入查询日期：</th>
  	<td align=left>
  	<input type="hidden" name="query_mode" value="mode_1">
  	<input type="text" name="query_date" size=10 value="<%=query_date%>">（格式：YYYY-MM-DD）
  	<input name="affirm_order" type="submit" value="查 询">
      <input name="affirm_order" type="reset" value="重 置">
  	</td> 
  </tr>
  </form>
</table><br>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">查询模式2：查看小组每日产量</td>
  </tr>
  <tr>
    <th>序号</th><th>生产小组</th><th>排产表号</th><th>通知单号</th><th>款号</th><th>操作</th>
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
  	<td align=center rowspan=<%=rowspan%>><%=rs("group_name")%></td>
  	<%
  	if rs3.recordcount=0 then
  	%>
  	  <td align=center>无</td><td align=center>无</td><td align=center>无</td><th>无</th></tr>
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
  	    <th>
  	    	<input name="input_arrange" type="button" onclick="MM_goToURL('self','show_day_produce.asp?arrange_no=<%=rs4("arrange_no")%>&day_group=<%=rs("group_name")%>&query_mode=mode_2');return document.MM_returnValue" value="查看每日产量明细">
  	    </th>
  	    </tr>
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
if day_group<>"" and arrange_no<>"" and query_mode="mode_2" then
  set rs5=Server.CreateObject("ADODB.Recordset")
  sql5="select date_start,date_finish from arrange_group_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"'"
  rs5.open sql5,conn,1,1
  cycle_num=datediff("d",rs5("date_start"),rs5("date_finish"))+1
  set rs6=Server.CreateObject("ADODB.Recordset")
  sql6="select design_no from arrange_info where arrange_no='"&arrange_no&"'"
  rs6.open sql6,conn,1,1
%>
  <table width="100%" cellspacing=1>
	  <tr>
  	  <td class="table_title" colspan="<%=cycle_num+2%>">生产小组“<%=day_group%>”每日产量明细</td>
    </tr>
    <tr>
      <th>款号</th>
      <%for i=0 to cycle_num-1%>
      <th><%=month(dateadd("d",i,rs5("date_start")))&"."&day(dateadd("d",i,rs5("date_start")))%></th>
      <%next%>
    </tr>
    <tr>
    	<td align=center><%=rs6("design_no")%></td>
    	<%
    	for i=0 to cycle_num-1
    	  set rs7=Server.CreateObject("ADODB.Recordset")
        sql7="select sum(day_amount) as day_amount_sum from day_produce_info where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and day_date='"&dateadd("d",i,rs5("date_start"))&"'"
        rs7.open sql7,conn,1,1
        day_amount_sum=0
        day_amount_sum=day_amount_sum+cint(rs7("day_amount_sum"))
        response.write "<td align=center>"&day_amount_sum&"</td>"
    	%>
    	<%next%>
    </tr>
  </table>
  <br><br>
<%
rs5.close
set rs5=nothing
rs6.close
set rs6=nothing
rs7.close
set rs7=nothing
end if
%>

<%
if query_mode="mode_1" then
  set rs8=Server.CreateObject("ADODB.Recordset")
  sql8="select distinct notify_no,day_no from day_produce_info where day_date='"&query_date&"'"
  rs8.open sql8,conn,1,1
  if rs8.eof then
    response.write "<center>没有"&query_date&"的日产数据！</center>"
  else
%>
    <table width="100%" cellspacing=1><tr><td class="table_title" colspan="13">生产小组日报表（日期：<%=query_date%> 编号：<%=rs8("day_no")%>）</td></tr></table>
<%
    while not rs8.eof
      set rs9=Server.CreateObject("ADODB.Recordset")
      sql9="select distinct day_group from day_produce_info where day_date='"&query_date&"' and notify_no='"&rs8("notify_no")&"'"
      rs9.open sql9,conn,1,1
%>
      <table width="100%" cellspacing=1>
      <tr><th colspan=2>生产通知单号</th><td colspan=2><%=rs8("notify_no")%></td>
      <th>订单号</th><td colspan=4>
<%
      set rs10=Server.CreateObject("ADODB.Recordset")
      sql10="select distinct order_no from notify_produce_info where notify_no='"&rs8("notify_no")&"'"
      rs10.open sql10,conn,1,1
      while not rs10.eof
        response.write rs10("order_no")&" &nbsp;"
        rs10.movenext
      wend
      rs10.close
      set rs10=nothing
%>
      </td></tr>
      <tr><th>部门</th><th>产品名称</th><th>款号</th><th>领活日期</th><th>本日领活</th><th>累计领活</th><th>实际完成</th><th>累计完成</th><th>在产品</th></tr>
<%
      while not rs9.eof
        '产品名称、款号
        set rs11=Server.CreateObject("ADODB.Recordset")
        sql11="select product_name,design_no from item_info where item_id=(select top 1 item_id from notify_produce_info where notify_no='"&rs8("notify_no")&"')"
        rs11.open sql11,conn,1,1
        '领活日期，即开始日期
        set rs12=Server.CreateObject("ADODB.Recordset")
        sql12="select date_start from arrange_group_info where arrange_no=(select top 1 arrange_no from day_produce_info where day_group='"&rs9("day_group")&"' and day_date='"&query_date&"' and notify_no='"&rs8("notify_no")&"') and arrange_group='"&rs9("day_group")&"'"
        'response.write sql12
        rs12.open sql12,conn,1,1
        '本日领活&累计领活
        set rs13=Server.CreateObject("ADODB.Recordset")
        sql13="select distinct arrange_no from day_produce_info where notify_no='"&rs8("notify_no")&"'"
        rs13.open sql13,conn,1,1
        send_amount_sum_today=0
        send_amount_sum_all=0
        while not rs13.eof
          '本日领活，即本日发活
          set rs14=Server.CreateObject("ADODB.Recordset")
          sql14="select sum(send_amount) as send_amount_sum_today from day_send_info where send_date='"&query_date&"' and send_group='"&rs9("day_group")&"' and arrange_no='"&rs13("arrange_no")&"'"
          rs14.open sql14,conn,1,1
          send_amount_sum_today=send_amount_sum_today+rs14("send_amount_sum_today")
          rs14.close
          set rs14=nothing
          '累计领活，即累计发活
          set rs15=Server.CreateObject("ADODB.Recordset")
          sql15="select sum(send_amount) as send_amount_sum_all from day_send_info where send_group='"&rs9("day_group")&"' and arrange_no='"&rs13("arrange_no")&"'"
          'response.write sql15
          rs15.open sql15,conn,1,1
          send_amount_sum_all=send_amount_sum_all+rs15("send_amount_sum_all")
          rs15.close
          set rs15=nothing
          rs13.movenext
        wend
        '实际完成
        set rs16=Server.CreateObject("ADODB.Recordset")
        sql16="select sum(day_amount) as day_amount_sum_today from day_produce_info where day_group='"&rs9("day_group")&"' and day_date='"&query_date&"' and notify_no='"&rs8("notify_no")&"'"
        'response.write sql16
        rs16.open sql16,conn,1,1
        '累计完成
        set rs17=Server.CreateObject("ADODB.Recordset")
        sql17="select sum(day_amount) as day_amount_sum_all from day_produce_info where day_group='"&rs9("day_group")&"' and notify_no='"&rs8("notify_no")&"'"
        'response.write sql17
        rs17.open sql17,conn,1,1
%>
        <tr><td align="center"><%=rs9("day_group")%></td>
        <td align="center"><%=rs11("product_name")%></td>
        <td align="center"><%=rs11("design_no")%></td>
        <td align="center"><%=rs12("date_start")%></td>
        <td align="center"><%=send_amount_sum_today%></td>
        <td align="center"><%=send_amount_sum_all%></td>
        <td align="center"><%=rs16("day_amount_sum_today")%></td>
        <td align="center"><%=rs17("day_amount_sum_all")%></td>
        <td align="center"><%=send_amount_sum_all-rs17("day_amount_sum_all")%></td>
<%
        rs9.movenext
        rs11.close
        set rs11=nothing
        rs12.close
        set rs12=nothing
        rs13.close
        set rs13=nothing
        rs16.close
        set rs16=nothing
        rs17.close
        set rs17=nothing
      wend
      rs9.close
      set rs9=nothing
      rs8.movenext
    wend
    rs8.close
    set rs8=nothing 
  end if
end if
%>
</body>
</html>