<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
'item_id=trim(request("item_id"))
set rs3=Server.CreateObject("ADODB.Recordset")
if session("userlev")="���ž���" then
  sql3="select item_id from item_info where state='¼��'"
else
  sql3="select item_id from item_info where functionary='"&trim(session("username"))&"' and state='¼��'"
end if
rs3.open sql3,conn,1,1
set rs4=Server.CreateObject("ADODB.Recordset")
if session("userlev")="���ž���" then
  sql4="select order_no from order_info where state='¼��'"
else
  sql4="select order_no from order_info where lister='"&trim(session("username"))&"' and state='¼��'"
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
<form action="edit_item.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">��ѯ��������Ϣ</td>
  </tr>
  <tr>
    <th align=right width="40%">��ѡ��Ҫ��ѯ�Ŀ�ź����ڣ�</th>
    <td>
    	<select name="item_id" style="width:240px">
    	<%while not rs3.eof%>
      <option value="<%=rs3("item_id")%>"><%=rs3("item_id")%></option>
      <%
        rs3.movenext
      wend
      rs3.close
      set rs3=nothing
      %>
      </select>
      <input type="submit" value="�� ѯ"> <input type="reset" value="�� ��">
    </td>
  </tr>
</table>
</form>
<form action="edit_order.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">��ѯ������Ϣ</td>
  </tr>
  <tr>
    <th align=right width="40%">��ѡ��Ҫ��ѯ�Ķ����ţ�</th>
    <td>
    	<select name="order_no" style="width:240px">
    	<%while not rs4.eof%>
      <option><%=rs4("order_no")%></option>
      <%
        rs4.movenext
      wend
      rs4.close
      set rs4=nothing
      %>
      </select>
      <input type="submit" value="�� ѯ"> <input type="reset" value="�� ��">
    </td>
  </tr>
</table>
</form>