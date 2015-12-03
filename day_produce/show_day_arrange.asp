<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next
day_group=trim(request("day_group"))
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
  	<td class="table_title" colspan="13">缝纫车间小组日排产表</td>
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
  	    	<input name="input_arrange" type="button" onclick="MM_goToURL('self','show_day_arrange.asp?arrange_no=<%=rs4("arrange_no")%>&day_group=<%=rs("group_name")%>');return document.MM_returnValue" value="查看小组日排产">
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
if day_group<>"" and arrange_no<>"" then
	set rs5=Server.CreateObject("ADODB.Recordset")
  sql5="select date_start,date_finish from arrange_group_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"'"
  rs5.open sql5,conn,1,1
  cycle_num=datediff("d",rs5("date_start"),rs5("date_finish"))+1
  set rs6=Server.CreateObject("ADODB.Recordset")
  sql6="select design_no from arrange_info where arrange_no='"&arrange_no&"'"
  rs6.open sql6,conn,1,1
  set rs7=Server.CreateObject("ADODB.Recordset")
  sql7="select product_name from item_info where design_no='"&rs6("design_no")&"'"
  rs7.open sql7,conn,1,1
%>
  <table width="100%" cellspacing=1>
	  <tr>
  	  <td class="table_title" colspan="<%=cycle_num+6%>">生产小组“<%=day_group%>”日排产情况</td>
    </tr>
    <tr>
      <th>款号</th><th>名称</th>
      <%for i=0 to cycle_num-1%>
      <th><%=month(dateadd("d",i,rs5("date_start")))&"."&day(dateadd("d",i,rs5("date_start")))%></th>
      <%next%>
      <th>合计</th><th>生产周期</th><th>平均日产</th><th>清批日期</th>
    </tr>
    <tr>
    	<td align=center><%=rs6("design_no")%></td><td align=center><%=rs7("product_name")%></td>
    	<%
    	base_num=0
    	set rs8=Server.CreateObject("ADODB.Recordset")
      sql8="select sum(arrange_amount) as arrange_amount_sum from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&day_group&"'"
      'response.write sql8
      rs8.open sql8,conn,1,1
    	'日排产有三种情况：
    	'1. 尚未开工或今天是开工第一天，所以昨天没有日产量，就以（平均日产/2）作为基数来计算日排产
    	if datediff("d",rs5("date_start"),datevalue(now()))<=0 then
        base_num=round(cint(rs8("arrange_amount_sum"))/cycle_num/2)
        response.write "<td align=center><font color=red>"&base_num&"</font></td>"
        intend_day_amount=base_num
        now_amount_sum=base_num
        for i=2 to cycle_num
          intend_day_amount=intend_day_amount*(1+4/i/i)
          intend_day_amount=round(intend_day_amount)
          '判断是否超出排产单数量总和
          if now_amount_sum+intend_day_amount<=cint(rs8("arrange_amount_sum")) then
          	output_day_amount=intend_day_amount
          	now_amount_sum=now_amount_sum+intend_day_amount
          elseif now_amount_sum<=cint(rs8("arrange_amount_sum")) then
          	output_day_amount=cint(rs8("arrange_amount_sum"))-now_amount_sum
          	now_amount_sum=now_amount_sum+intend_day_amount
          else
          	output_day_amount=0
          end if
          response.write "<td align=center><font color=red>"&output_day_amount&"</font></td>"
        next
    	'2. 如果已经开工且不是第一天，而且没有完工，昨天有日产量，今天以前显示实际生产量，今天及以后就以昨天产量为基数计算预排产量
    	elseif datediff("d",rs5("date_finish"),datevalue(now()))<=0 then
    		set rs9=Server.CreateObject("ADODB.Recordset")
        sql9="select sum(day_amount) as day_amount_sum from day_produce_info where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and day_date='"&dateadd("d",-1,datevalue(now()))&"'"
        rs9.open sql9,conn,1,1
        base_num=cint(rs9("day_amount_sum"))
        rs9.close
        set rs9=nothing
        now_amount_sum=0
        for i=0 to datediff("d",rs5("date_start"),datevalue(now()))-1
          set rs10=Server.CreateObject("ADODB.Recordset")
          sql10="select sum(day_amount) as day_amount_sum from day_produce_info where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and day_date='"&dateadd("d",i,rs5("date_start"))&"'"
          rs10.open sql10,conn,1,1
          day_amount_sum=0
          day_amount_sum=day_amount_sum+cint(rs10("day_amount_sum"))
          now_amount_sum=now_amount_sum+day_amount_sum
          response.write "<td align=center>"&day_amount_sum&"</td>"
          rs10.close
          set rs10=nothing
        next
        intend_day_amount=base_num
        for i=datediff("d",rs5("date_start"),datevalue(now()))+1 to cycle_num
          intend_day_amount=intend_day_amount*(1+4/i/i)
          intend_day_amount=round(intend_day_amount)
          '判断是否超出排产单数量总和
          if now_amount_sum+intend_day_amount<=cint(rs8("arrange_amount_sum")) then
          	output_day_amount=intend_day_amount
          	now_amount_sum=now_amount_sum+intend_day_amount
          elseif now_amount_sum<=cint(rs8("arrange_amount_sum")) then
          	output_day_amount=cint(rs8("arrange_amount_sum"))-now_amount_sum
          	now_amount_sum=now_amount_sum+intend_day_amount
          else
          	output_day_amount=0
          end if
          response.write "<td align=center><font color=red>"&output_day_amount&"</font></td>"
        next
    	'3. 已经完工
    	else
    		for i=0 to cycle_num-1
          set rs11=Server.CreateObject("ADODB.Recordset")
          sql11="select sum(day_amount) as day_amount_sum from day_produce_info where arrange_no='"&arrange_no&"' and day_group='"&day_group&"' and day_date='"&dateadd("d",i,rs5("date_start"))&"'"
          rs11.open sql11,conn,1,1
          day_amount_sum=0
          day_amount_sum=day_amount_sum+cint(rs11("day_amount_sum"))
          response.write "<td align=center>"&day_amount_sum&"</td>"
          rs11.close
          set rs11=nothing
        next
    	end if
    	%>
      <td align=center><%=rs8("arrange_amount_sum")%></td><td align=center><%=cycle_num%></td><td align=center><%=fix(cint(rs8("arrange_amount_sum"))/cycle_num)%></td><td align=center><%=rs5("date_finish")%></td>
    </tr>
  </table>
  <br><br>
<%
rs8.close
set rs8=nothing
rs5.close
set rs5=nothing
rs6.close
set rs6=nothing
rs7.close
set rs7=nothing
end if
%>
</body>
</html>