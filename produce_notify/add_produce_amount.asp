<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
suborder_no=trim(request("suborder_no"))
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
suborder_color=trim(request("suborder_color"))
suborder_size=trim(request("suborder_size"))
produce_amount=trim(request("produce_amount"))
suborder_no_arr=split(suborder_no,",")
suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
produce_amount_arr=split(produce_amount,",")

'op_num=0
for i=0 to ubound(suborder_no_arr)
  if trim(produce_amount_arr(i))<>"" and trim(produce_amount_arr(i))<>"0" then
  	set rs3=Server.CreateObject("ADODB.Recordset")
    sql3="select * from notify_produce_info where notify_no='"&notify_no&"' and suborder_no="&trim(suborder_no_arr(i))&" and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
    rs3.open sql3,conn,1,1
    if not rs3.eof then
    	set rs2=Server.CreateObject("ADODB.Recordset")
      sql2="update notify_produce_info set produce_amount=produce_amount+"&cint(trim(produce_amount_arr(i)))&" where notify_no='"&notify_no&"' and suborder_no="&trim(suborder_no_arr(i))&" and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
      rs2.open sql2,conn,1,3
      rs2.close
      set rs2=nothing
    else
      set rs=Server.CreateObject("ADODB.Recordset")
      sql="insert into notify_produce_info (notify_no,suborder_no,order_no,item_id,suborder_color,suborder_size,produce_amount) values ('"&notify_no&"',"&trim(suborder_no_arr(i))&",'"&order_no&"','"&item_id&"','"&trim(suborder_color_arr(i))&"','"&trim(suborder_size_arr(i))&"',"&trim(produce_amount_arr(i))&")"
      rs.open sql,conn,1,3
      rs.close
      set rs=nothing
    end if
    rs3.close
    set rs3=nothing
    'op_num=op_num+1
  end if
next
'errmsg="输入成功！本次操作共输入了"&op_num&"条记录。"
'response.end
%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body topmargin=0 leftmargin=0>
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
  	<td class="table_title" colspan="<%=title_span+2%>">生产通知单“<%=notify_no%>”当前输入结果</td>
  </tr>
  <tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尺码<br>数量<br>色号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<%
   while not rs3.eof
  	  set rs_inlen=Server.CreateObject("ADODB.Recordset")
      sql_inlen="select top 1 suborder_inlen from suborder_info where order_no='"&order_no&"'"
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
  <input name="input_order" type="button" onclick="MM_goToURL('self','show_item.asp?item_id=<%=item_id%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="继续输入">
  <input name="input_order" type="button" onclick="MM_goToURL('self','input_add_amount.asp?notify_no=<%=notify_no%>&item_id=<%=item_id%>&design_no=<%=design_no%>');return document.MM_returnValue" value="进行加裁">
</center>
  </body>
</html>