<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
worker_name=trim(request("worker_name"))
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
  		<form action="del_worker.asp" method=post target="mainFrame">
  		<input type="hidden" name="worker_name" value="<%=worker_name%>">
      <tr>
        <td>确认要删除小组员工“<%=worker_name%>”吗？<br>确认删除请单击“删除”按钮，取消该操作请单击“取消”按钮。</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="删 除">
        <input type="submit" name="is_del" value="取 消"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>