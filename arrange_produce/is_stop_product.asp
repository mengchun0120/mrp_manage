<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
arrange_no=trim(request("arrange_no"))
arrange_group=trim(request("arrange_group"))
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
  			<td class="table_title" colspan=2>是否停产</td>
  		</tr>
  		<form action="stop_product.asp" method=post target="mainFrame">
  		<input type="hidden" name="arrange_no" value="<%=arrange_no%>">
  		<input type="hidden" name="arrange_group" value="<%=arrange_group%>">
      <tr>
        <td>确认要停产吗？<br>确认停产请单击“停产”按钮，取消该操作请单击“取消”按钮。</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="停 产">
        <input type="submit" name="is_del" value="取 消"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>