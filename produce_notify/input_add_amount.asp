<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
design_no=trim(request("design_no"))
notify_no=trim(request("notify_no"))
item_id=trim(request("item_id"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<form method=post action="add_add_amount.asp">
<%
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
  	<td class="table_title" colspan="<%=title_span+2%>">生产通知单“<%=notify_no%>”的信息</td>
  </tr>
  <tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尺码<br>数量<br>色号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<%
   while not rs3.eof
  	  set rs_inlen=Server.CreateObject("ADODB.Recordset")
      sql_inlen="select top 1 suborder_inlen from suborder_info where order_no=(select top 1 order_no from order_info where item_id='"&item_id&"')"
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
        'response.write "|"&trim(rs4("produce_amount_sum"))&"|"&sql4
        if rs4.eof then
        	response.write "<td align=center>&nbsp;</td>"
        else
        	tmp=0
        	while not rs4.eof
        	  addup=addup+cint(rs4("produce_amount"))
        	  tmp=tmp+cint(rs4("produce_amount"))
        	  rs4.movenext
        	wend
          response.write "<td align=center>"&tmp
          auto_add_amount=round(tmp*0.01)
          if auto_add_amount=0 then
          	auto_add_amount=1
          end if
          %>
          <input type=text size=5 name="add_amount" value="<%=auto_add_amount%>">
          <input type=hidden name="suborder_color" value="<%=rs2("suborder_color")%>">
          <input type=hidden name="suborder_size" value="<%=rs3("suborder_size")%>">
          </td>
          <%
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
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan="<%=title_span+1%>"><textarea name="remark" cols=92 rows=4></textarea></td>
  </tr>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<%end if%>
<br>
<center>
<input type=hidden name="notify_no" value="<%=notify_no%>">
<input type=hidden name="design_no" value="<%=design_no%>">
<input type=hidden name="item_id" value="<%=item_id%>">
<input name="affirm_order" type="submit" value="确认输入">
<input name="affirm_order" type="reset" value="重新输入">
<input name="input_order" type="button" onclick="MM_goToURL('self','show_item.asp?item_id=<%=item_id%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="返 回">
</form>
<br><br>
</center>
</body>
</html>