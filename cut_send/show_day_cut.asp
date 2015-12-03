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
  	<td class="table_title" colspan=2>裁剪车间日裁剪量信息</td>
  </tr>
  <form action="show_day_cut.asp" method=post target="mainFrame">
  <tr>
  	<th>输入查询日期：</th>
  	<td align=left><input type="text" name="cut_date" size=10 value="<%=cut_date%>">（格式：YYYY-MM-DD）
  		<input name="affirm_order" type="submit" value="查 询">
      <input name="affirm_order" type="reset" value="重 置">
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
  	response.write "<br><center>没有"&cut_date&"的裁剪量信息！</center>"
  else
    title_span=rs.recordcount
%>
<table width="100%" cellspacing=1>
	<tr>
    <th>通知单号</th>
<%
   while not rs.eof
  	  response.write "<th>"&rs("notify_no")&"</th>"
  	  rs.movenext
   wend
  	response.write "<th>合计</th></tr>"
  	rs.movefirst
%>
  <tr>
    <th>裁剪数量</th>
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