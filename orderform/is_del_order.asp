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
  			<td class="table_title" colspan=2>是否删除</td>
  		</tr>
  		<form action="del_order.asp" method=post target="mainFrame">
      <tr>
        <input type="hidden" name="item_id" value="<%=item_id%>">
        <input type="hidden" name="order_no" value="<%=order_no%>">
        <input type="hidden" name="goto_url" value="edit_item.asp">
        <td>如果删除该订单，则该订单的信息以及所包含的订单项信息也将一并删除，而且所有删除的信息无法恢复！<br>确认删除请单击“删除”按钮，取消该操作请单击“取消”按钮。</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="删 除">
        <input type="submit" name="is_del" value="取 消"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>