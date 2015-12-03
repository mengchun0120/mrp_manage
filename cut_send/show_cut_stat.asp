<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next
start_date=trim(request("start_date"))
end_date=trim(request("end_date"))
if start_date="" or isdate(start_date)=0 then
	start_date=year(now())&"-1-1"
end if
if end_date="" or isdate(end_date)=0 then
	end_date=datevalue(now())
end if
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
  	<td class="table_title" colspan=2>请输入查询起始日期和结束日期</td>
  </tr>
  <form action="show_cut_stat.asp" method=post target="mainFrame">
  <tr>
  	<th>输入起始日期和结束日期：</th>
  	<td align=left> 从 <input type="text" name="start_date" size=10 value="<%=start_date%>">（格式：YYYY-MM-DD） 到 <input type="text" name="end_date" size=10 value="<%=end_date%>">（格式：YYYY-MM-DD）
  		<input name="affirm_order" type="submit" value="查 询">
      <input name="affirm_order" type="reset" value="重 置">
  	</td> 
  </tr>
  </form>
</table>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">裁剪车间完成品统计</td>
  </tr>
  <tr>
    <th>序号</th><th>款号</th><th>通知单号</th><th>需要数量</th><th>已完成</th><th>待产</th><th>已发</th><th>待发</th><th>完成比例</th>
  </tr>
  <%
  serial_no=0
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="select distinct design_no from day_cut_info where cut_date between '"&start_date&"' and '"&end_date&"'"
  rs.open sql,conn,1,1
  'response.write sql&"|||"&rs.recordcount&"<br>"
  while not rs.eof
    serial_no=serial_no+1
    set rs3=Server.CreateObject("ADODB.Recordset")
    sql3="select distinct notify_no from day_cut_info where design_no='"&rs("design_no")&"' and (cut_date between '"&start_date&"' and '"&end_date&"')"
    'response.write sql3
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
  	<td align=center rowspan=<%=rowspan%>><%=rs("design_no")%></td>
  	<%
  	if rs3.recordcount=0 then
  	%>
  	  <td align=center>无</td><td align=center>无</td><td align=center>无</td><td align=center>无</td><td align=center>无</td><td align=center>无</td><td align=center>无</td></tr>
  	<%
    else
  	  tr_flag=0
  	  while not rs3.eof
  	    tr_flag=tr_flag+1
  	    '需要总数(包括加裁量)
  	    set rs4=Server.CreateObject("ADODB.Recordset")
        sql4="select sum(produce_amount) as produce_amount_sum from notify_produce_info where notify_no='"&rs3("notify_no")&"'"
        rs4.open sql4,conn,1,1
        set rs41=Server.CreateObject("ADODB.Recordset")
        sql41="select sum(add_amount) as add_amount_sum from notify_add_amount where notify_no='"&rs3("notify_no")&"'"
        rs41.open sql41,conn,1,1
        produce_amount_sum=0
        produce_amount_sum=produce_amount_sum+cint(rs4("produce_amount_sum"))+cint(rs41("add_amount_sum"))
        rs4.close
  	    set rs4=nothing
  	    '已完成
  	    set rs5=Server.CreateObject("ADODB.Recordset")
        sql5="select sum(cut_amount) as cut_amount_sum from day_cut_info where notify_no='"&rs3("notify_no")&"' and (cut_date between '"&start_date&"' and '"&end_date&"')"
        rs5.open sql5,conn,1,1
        cut_amount_sum=0
        cut_amount_sum=cut_amount_sum+cint(rs5("cut_amount_sum"))
        rs5.close
  	    set rs5=nothing
  	    '已发
  	    set rs6=Server.CreateObject("ADODB.Recordset")
        sql6="select sum(send_amount) as send_amount_sum from day_send_info where arrange_no=(select arrange_no from arrange_info where notify_no='"&rs3("notify_no")&"') and (send_date between '"&start_date&"' and '"&end_date&"')"
        'response.write sql6
        rs6.open sql6,conn,1,1
        send_amount_sum=0
        send_amount_sum=send_amount_sum+cint(rs6("send_amount_sum"))
        rs6.close
  	    set rs6=nothing
  	%>
  	    <td align=center><%=rs3("notify_no")%></td>
  	    <td align=center><%=produce_amount_sum%></td>
  	    <td align=center><%=cut_amount_sum%></td>
  	    <td align=center><%=produce_amount_sum-cut_amount_sum%></td>
  	    <td align=center><%=send_amount_sum%></td>
  	    <td align=center><%=cut_amount_sum-send_amount_sum%></td>
  	    <td align=center><%=round(cut_amount_sum/produce_amount_sum*100)%>%</td>
  	    </tr>
  	<%
  	    if tr_flag<rs3.recordcount then
  	  	  response.write "<tr>"
  	    end if
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
</body>
</html>