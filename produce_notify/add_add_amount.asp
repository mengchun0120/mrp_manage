<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
item_id=trim(request("item_id"))
add_amount=trim(request("add_amount"))
suborder_color=trim(request("suborder_color"))
suborder_size=trim(request("suborder_size"))
remark=trim(request("remark"))
if remark="" then
	remark="��"
end if

set rs4=Server.CreateObject("ADODB.Recordset")
sql4="update notify_info set remark='"&remark&"' where notify_no='"&notify_no&"'"
rs4.open sql4,conn,1,3
rs4.close
set rs4=nothing

suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
add_amount_arr=split(add_amount,",")
'response.write notify_no&"|"&add_amount&"|"&suborder_color&"|"&suborder_size&"|"
'op_num=0
for i=0 to ubound(suborder_color_arr)
  if trim(add_amount_arr(i))="" then
  	tmp=0
  else
  	tmp=cint(trim(add_amount_arr(i)))
  end if
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select * from notify_add_amount where notify_no='"&notify_no&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  	set rs2=Server.CreateObject("ADODB.Recordset")
    sql2="update notify_add_amount set add_amount="&tmp&" where notify_no='"&notify_no&"' and suborder_color='"&trim(suborder_color_arr(i))&"' and suborder_size='"&trim(suborder_size_arr(i))&"'"
    rs2.open sql2,conn,1,3
    rs2.close
    set rs2=nothing
  else
    set rs=Server.CreateObject("ADODB.Recordset")
    sql="insert into notify_add_amount (notify_no,suborder_color,suborder_size,add_amount) values ('"&notify_no&"','"&trim(suborder_color_arr(i))&"','"&trim(suborder_size_arr(i))&"',"&trim(add_amount_arr(i))&")"
    rs.open sql,conn,1,3
    rs.close
    set rs=nothing
  end if
  rs3.close
  set rs3=nothing
  'op_num=op_num+1
next
'errmsg="�Ӳ�������ɹ������β�����������"&op_num&"����¼��"
'return_url="show_notify.asp?notify_no="&notify_no&"&design_no="&design_no&"&item_id="&item_id
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
  	<td class="table_title" colspan="<%=title_span+2%>">����֪ͨ����<%=notify_no%>����������Ϣ</td>
  </tr>
  <tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<br>����<br>ɫ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
  	response.write "<th>�ϼ�</th></tr>"
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
    <th>�� &nbsp;&nbsp;&nbsp;ע��</th>
    <td colspan="<%=title_span+1%>"><%=trans_code(rs6("remark"))%></td>
  </tr>
</table>
<div align=right>�Ʊ��ˣ�<%=rs6("lister")%>&nbsp;&nbsp;�Ʊ����ڣ�<%=rs6("date_created")%>&nbsp;&nbsp;�ϼ�������<%=alladdup%></div>
<%
  rs6.close
  set rs6=nothing
end if
%>
<br>
<center>
<input name="input_order" type="button" onclick="MM_goToURL('self','notify_finished.asp?notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="ȷ���������">
<input name="input_order" type="button" onclick="MM_goToURL('self','input_add_amount.asp?item_id=<%=item_id%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="�� ��">
<br><br>
</center>
  </body>
</html>