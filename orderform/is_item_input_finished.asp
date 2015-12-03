<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
order_no=trim(request("order_no"))
item_id=trim(request("item_id"))
goto_url=trim(request("goto_url"))
%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=0>
  		<tr>
  			<td class="table_title" colspan=2>要求确认</td>
  		</tr>
  		<form action="item_input_finished.asp" method=post target="mainFrame">
      <tr>
        <input type="hidden" name="order_no" value="<%=order_no%>">
        <input type="hidden" name="item_id" value="<%=item_id%>">
        <input type="hidden" name="goto_url" value="<%=goto_url%>">
        <td>该生产项的所有数据是否已经录入完毕？<br>如果录入完毕请单击“确定”按钮，取消该操作请单击“取消”按钮。</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="确 定">
        <input type="submit" name="is_del" value="取 消"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>