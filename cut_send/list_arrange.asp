<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
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
  	<td class="table_title" colspan="13">��ѡ��Ҫ����С�鼰�Ų���</td>
  </tr>
  <tr>
    <th>���</th><th>����С��</th><th>�Ų����</th><th>֪ͨ����</th><th>���</th><th>����</th>
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
  	  <td align=center>��</td><td align=center>��</td><td align=center>��</td><th>��</th></tr>
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
  	    	<input name="input_arrange" type="button" onclick="MM_goToURL('self','input_day_send.asp?arrange_no=<%=rs4("arrange_no")%>&send_group=<%=rs("group_name")%>');return document.MM_returnValue" value="¼�뷢������">
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
  'rsѭ������
  rs.close
  set rs=nothing
  %>
</table>
<br>
</body>
</html>