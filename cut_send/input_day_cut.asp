<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next

notify_no=trim(request("notify_no"))
design_no=trim(request("design_no"))
'response.write notify_no&"|"&design_no&"|"&arrange_no&"|"&arrange_group&"|"
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
  	<td class="table_title" colspan=<%=title_span+2%>>��������֪ͨ����<%=notify_no%>�����ղü���</td>
  </tr>
  <form action="add_day_cut.asp" method=post target="mainFrame">
  <tr>
  	<th>�������ڣ�</th><td align=left  colspan=<%=title_span+1%>><input type="text" name="cut_date" size=10 value="<%=datevalue(now())%>">����ʽ��YYYY-MM-DD��</td>
  </tr>
	<tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<br>����<br>ɫ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
          '��ʵ������ͬ�Ӳ������
          tmp=tmp+cint(rs5("add_amount"))
          '�ҳ����и���֪ͨ����ص��Ų����
          cut_amount_sum=0
          '�ó��ü������ղ����и���֪ͨ����ص�����ͬ��ɫͬ���������
        	set rs8=Server.CreateObject("ADODB.Recordset")
          sql8="select sum(cut_amount) as cut_amount_sum from day_cut_info where notify_no='"&notify_no&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
          'response.write sql8
          rs8.open sql8,conn,1,1
          cut_amount_sum=cut_amount_sum+cint(rs8("cut_amount_sum"))
          rs8.close
  	      set rs8=nothing
  	      '�ټ�ȥ�Ѿ��ü������������͵ó�����ɫ�ó���ʵ��δ�ü�������
  	      'tmp=tmp-cut_amount_sum
          %>
          <td align=center><%=tmp%>-<%=cut_amount_sum%>=<%=tmp-cut_amount_sum%>
          <input type=text size=5 name="cut_amount">
          <input type=hidden name="suborder_color" value="<%=rs2("suborder_color")%>">
          <input type=hidden name="suborder_size" value="<%=rs3("suborder_size")%>">
          </td>
          <%
          addup=addup+cint(rs5("add_amount"))-cut_amount_sum
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
<input type=hidden name="notify_no" value="<%=notify_no%>">
<input type=hidden name="design_no" value="<%=design_no%>">
<input name="affirm_order" type="submit" value="ȷ������">
<input name="affirm_order" type="reset" value="��������">
<input name="input_order" type="button" onclick="MM_goToURL('self','list_notify.asp?notify_no=<%=notify_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="�� ��">
</form>
<br><br>
</center>
  </body>
</html>