<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next
notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from notify_info where state='录入完成' order by date_created desc"
rs.open sql,conn,1,1
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
  	<td class="table_title" colspan="6">请选择要查询的生产通知单号</td>
  </tr>
  <tr>
    <th>生产通知单号</th><th>款号</th><th>制表人</th><th>创建日期</th><th>状态</th><th>操作</th>
  </tr>
  <%while not rs.eof%>
  <form action="list_notify.asp" method=post target="mainFrame">
  <input type=hidden name="notify_no" value="<%=rs("notify_no")%>">
  <input type=hidden name="design_no" value="<%=rs("design_no")%>">
  <tr>
    <td align=center><%=rs("notify_no")%></td><td align=center><%=rs("design_no")%></td><td align=center><%=rs("lister")%></td><td align=center><%=rs("date_created")%></td><td align=center><%=rs("state")%></td><td align=center><input type="submit" value="查看详情"></td>
  </tr>
  </form>
  <%  rs.movenext
    wend
    rs.close
    set rs=nothing
  %>
</table>
<br>
<%
if notify_no<>"" then
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from notify_produce_info where notify_no='"&notify_no&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from notify_produce_info where notify_no='"&notify_no&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=rs3.recordcount
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="<%=title_span+2%>">生产通知单“<%=notify_no%>”的详细信息</td>
  </tr>
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
        sql4="select produce_amount from notify_produce_info where notify_no='"&notify_no&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
        rs4.open sql4,conn,1,1
        if rs4.eof then
        	response.write "<td align=center>&nbsp;</td>"
        else
        	tmp=0
        	while not rs4.eof
        	  addup=addup+cint(rs4("produce_amount"))
        	  tmp=tmp+cint(rs4("produce_amount"))
        	  rs4.movenext
        	wend
        	set rs5=Server.CreateObject("ADODB.Recordset")
          sql5="select add_amount from notify_add_amount where notify_no='"&notify_no&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
          rs5.open sql5,conn,1,1
          response.write "<td align=center>"&tmp&" + <font color=red>"&rs5("add_amount")&"</font></td>"
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
  sql6="select * from notify_info where notify_no='"&notify_no&"'"
  rs6.open sql6,conn,1,1
%>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan="<%=title_span+1%>"><%=trans_code(rs6("remark"))%></td>
  </tr>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<%
  rs6.close
  set rs6=nothing
end if
%>
<br>
<center>
	<input name="input_arrange" type="button" onclick="MM_goToURL('self','input_day_cut.asp?notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="录入裁剪日产量">
</center>
<br>
<%end if%>
</body>
</html>