<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next

cut_date=trim(request("cut_date"))
%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body topmargin=0 leftmargin=0>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=2>�ü������ղü�����Ϣ</td>
  </tr>
  <form action="show_day_cut.asp" method=post target="mainFrame">
  <tr>
  	<th>�����ѯ���ڣ�</th>
  	<td align=left><input type="text" name="cut_date" size=10 value="<%=cut_date%>">����ʽ��YYYY-MM-DD��
  		<input name="affirm_order" type="submit" value="�� ѯ">
      <input name="affirm_order" type="reset" value="�� ��">
  	</td> 
  </tr>
</form>
</table>
<%
if cut_date<>"" then
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="SELECT SUM(cut_amount) AS cut_amount_sum, notify_no FROM day_cut_info WHERE cut_date = '"&cut_date&"' GROUP BY notify_no"
  rs.open sql,conn,1,1
  if rs.eof then
  	response.write "<br><center>û��"&cut_date&"�Ĳü�����Ϣ��</center>"
  else
    title_span=rs.recordcount
%>
<table width="100%" cellspacing=1>
	<tr>
    <th>֪ͨ����</th>
<%
   while not rs.eof
  	  response.write "<th>"&rs("notify_no")&"</th>"
  	  rs.movenext
   wend
  	response.write "<th>�ϼ�</th></tr>"
  	rs.movefirst
%>
  <tr>
    <th>�ü�����</th>
<%
   addup=0
   while not rs.eof
  	  response.write "<td align=center>"&rs("cut_amount_sum")&"</td>"
  	  addup=addup+cint(rs("cut_amount_sum"))
  	  rs.movenext
   wend
   response.write "<td align=center>"&addup&"</td></tr>"
   rs.close
   set rs=nothing
%>
</table>
<%
  end if
end if
%>
  </body>
</html>