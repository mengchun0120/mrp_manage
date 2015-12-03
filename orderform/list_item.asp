<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<%
on error resume next
order_by=trim(request("order_by"))
if order_by="" then
	order_by="date_created"
end if

set rs4=Server.CreateObject("ADODB.Recordset")
if session("userlev")="部门经理" then
  sql4="select * from item_info order by "&order_by
else
  sql4="select * from item_info where functionary='"&trim(session("username"))&"' order by "&order_by
end if
rs4.open sql4,conn,1,1
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
  	<td class="table_title" colspan="4">请选择要编辑的款号或订单号</td>
  </tr>
  <tr>
    <th><a href="list_item.asp?order_by=item_id">款号</a></th><th><a href="list_item.asp?order_by=client_name">客户名称</a></th><th><a href="list_item.asp?order_by=product_name">产品名称</a></th><th>订单号</th>
  </tr>
  <%
  while not rs4.eof
    set rs5=Server.CreateObject("ADODB.Recordset")
    sql5="select order_no from order_info where item_id='"&rs4("item_id")&"' order by date_created"
    'response.write sql5
    rs5.open sql5,conn,1,1
  %>
  <tr>
    <td align=center><a href="edit_item.asp?item_id=<%=rs4("item_id")%>"><%=rs4("design_no")%></a></td><td align=center><%=rs4("client_name")%></td><td align=center><%=rs4("product_name")%></td>
    <td align=left>
    	<%
    	if_br=0
    	while not rs5.eof
    	  if_br=if_br+1
    	  response.write "&nbsp;&nbsp;<a href='edit_order.asp?order_no="&rs5("order_no")&"'>"&rs5("order_no")&"</a>&nbsp;&nbsp;"
    	  if if_br=4 then
    	  	if_br=0
    	  	response.write "<br>"
    	  end if
    	  rs5.movenext
    	wend
    	%>
    </td>
  </tr>
  <%
        rs4.movenext
        rs5.close
        set rs5=nothing
      wend
      rs4.close
      set rs4=nothing
      %>
</table>
<br>
</body>
</html>