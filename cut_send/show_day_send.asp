<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next

send_date=trim(request("send_date"))
if send_date="" or isdate(send_date)=0 then
	send_date=datevalue(now())
end if
%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body topmargin=0 leftmargin=0>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=2>�ü������շ�������Ϣ</td>
  </tr>
  <form action="show_day_send.asp" method=post target="mainFrame">
  <tr>
  	<th width="120">�����ѯ���ڣ�</th>
  	<td align=left><input type="text" name="send_date" size=10 value="<%=send_date%>">����ʽ��YYYY-MM-DD��
  		<input name="affirm_order" type="submit" value="�� ѯ">
      <input name="affirm_order" type="reset" value="�� ��">
  	</td> 
  </tr>
  </form>
</table>
<%
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct arrange_no from day_send_info where send_date='"&send_date&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct send_group from day_send_info where send_date='"&send_date&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=rs3.recordcount
%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=<%=title_span+2%>>�ü����䡰<%=send_date%>���շ�����</td>
  </tr>
	<tr>
    <th width="120" class="table_double">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;С��<br>����<br>�Ų���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<%
   while not rs3.eof
  	  response.write "<th>"&rs3("send_group")&"</th>"
  	  rs3.movenext
   wend
  	response.write "<th>�ϼ�</th></tr>"
  	rs3.movefirst
  	alladdup=0
  	while not rs2.eof
  	  response.write "<tr><th>"&rs2("arrange_no")&"</th>"
  	  rs3.movefirst
  	  addup=0
  	  while not rs3.eof
  	    set rs4=Server.CreateObject("ADODB.Recordset")
        sql4="select sum(send_amount) as send_amount_sum from day_send_info where arrange_no='"&rs2("arrange_no")&"' and send_group='"&rs3("send_group")&"'"
        rs4.open sql4,conn,1,1
        'response.write "|"&trim(rs4("produce_amount_sum"))&"|"&sql4
        send_amount_sum=0
        addup=addup+cint(rs4("send_amount_sum"))
        send_amount_sum=send_amount_sum+cint(rs4("send_amount_sum"))
        if send_amount_sum=0 then
        	response.write "<td align=center>&nbsp;</td>"
        else
          response.write "<td align=center>"&send_amount_sum&"</td>"
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
<div align=right>�ϼ�������<%=alladdup%></div>
<%end if%>
<br>
</body>
</html>