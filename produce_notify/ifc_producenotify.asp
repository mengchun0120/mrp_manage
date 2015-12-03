<!--#include file="../inc/conn.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<%
order_no=request.form("order_no")
i=request.form("i")
j=request.form("j")
suborder_no=request.form("subord_no")
suborder=request.form("subord")
a=split(suborder_no,",")
b=split(suborder,",")

set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select distinct suborder_color from suborder_info where order_no='"&order_no&"'"
rs2.open sql2,conn,1,1
if not rs2.eof then
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select distinct suborder_size from suborder_info where order_no='"&order_no&"'"
  rs3.open sql3,conn,1,1
  if not rs3.eof then
  title_span=0
  while not rs3.eof
    title_span=title_span+1
    rs3.movenext
  wend
  rs3.movefirst
%>

<form method=post action="ifc_producenotify.asp">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="<%=title_span+2%>">订单“<%=order_no%>”的订单项信息</td>
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
  	response.write "<th>"
  	response.write "合计"
  	response.write "</th>"
  	rs3.movefirst
  	alladdup=0
  	i=1
  	m=0
  	while not rs2.eof
  	  response.write "<tr><th>"&rs2("suborder_color")&"</th>"
  	  rs3.movefirst
  	  addup=0
  	  j=1
  	  while not rs3.eof
  	    'set rs4=Server.CreateObject("ADODB.Recordset")
            'sql4="select suborder_amount,suborder_no from suborder_info where order_no='"&order_no&"' and suborder_color='"&rs2("suborder_color")&"' and suborder_size='"&rs3("suborder_size")&"'"
            'rs4.open sql4,conn,1,1
        if trim(b(m))="" then
        	response.write "<td align=center>0</td>"
        else
          addup=addup+cint(b(m))%>
          <td align=center><%=b(m)%>
          <input type=text size=5 name="subord">
          <input type=hidden name="subord_no" value="<%=rs4("suborder_no")%>"></td>
          <%
        j=j+1
        end if
  	    'rs4.close
  	    'set rs4=nothing
  	    m=m+1
  	    rs3.movenext
  	  wend
  	  response.write "<td align=center>"&addup&"</td></tr>"
  	  alladdup=alladdup+addup
  	  i=i+1
  	  rs2.movenext
  	wend
  end if
end if
i=i-1
j=j-1
%>
<tr>
	<th>备 &nbsp;注：</th>
	<td  colspan="<%=title_span+1%>"><textarea name=remark cols=81 rows=4></textarea></td>
</tr>
</table>
<div align=right>合计数量：<%=alladdup%></div>
<br>
<center>
<input type=hidden name=i value="<%=i%>">
<input type=hidden name=j value="<%=j%>">
<input type=hidden name=order_no value="<%=order_no%>">
<input name="affirm_order" type="submit" value="确认输入">
<input name="affirm_order" type="reset" value="重新输入">
</form>
<%
rs2.close
set rs2=nothing
rs3.close
set rs3=nothing
%>
</body>
</html>