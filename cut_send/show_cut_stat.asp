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
  	<td class="table_title" colspan=2>�������ѯ��ʼ���ںͽ�������</td>
  </tr>
  <form action="show_cut_stat.asp" method=post target="mainFrame">
  <tr>
  	<th>������ʼ���ںͽ������ڣ�</th>
  	<td align=left> �� <input type="text" name="start_date" size=10 value="<%=start_date%>">����ʽ��YYYY-MM-DD�� �� <input type="text" name="end_date" size=10 value="<%=end_date%>">����ʽ��YYYY-MM-DD��
  		<input name="affirm_order" type="submit" value="�� ѯ">
      <input name="affirm_order" type="reset" value="�� ��">
  	</td> 
  </tr>
  </form>
</table>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">�ü��������Ʒͳ��</td>
  </tr>
  <tr>
    <th>���</th><th>���</th><th>֪ͨ����</th><th>��Ҫ����</th><th>�����</th><th>����</th><th>�ѷ�</th><th>����</th><th>��ɱ���</th>
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
  	  <td align=center>��</td><td align=center>��</td><td align=center>��</td><td align=center>��</td><td align=center>��</td><td align=center>��</td><td align=center>��</td></tr>
  	<%
    else
  	  tr_flag=0
  	  while not rs3.eof
  	    tr_flag=tr_flag+1
  	    '��Ҫ����(�����Ӳ���)
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
  	    '�����
  	    set rs5=Server.CreateObject("ADODB.Recordset")
        sql5="select sum(cut_amount) as cut_amount_sum from day_cut_info where notify_no='"&rs3("notify_no")&"' and (cut_date between '"&start_date&"' and '"&end_date&"')"
        rs5.open sql5,conn,1,1
        cut_amount_sum=0
        cut_amount_sum=cut_amount_sum+cint(rs5("cut_amount_sum"))
        rs5.close
  	    set rs5=nothing
  	    '�ѷ�
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
  'rsѭ������
  rs.close
  set rs=nothing
  %>
</table>
<br>
</body>
</html>