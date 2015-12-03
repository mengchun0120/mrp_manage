<%conid=request.querystring("conid")
order=request("order")
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
  		<form action="in_del_dhjs.asp" method=post>
      <tr>
        <input type="hidden" name="conid" value="<%=conid%>">
        <input type="hidden" name=order value="<%=order%>">
        <td>如果删除该项，则该项的信息以及所包含的所有信息也将一并删除，而且所有删除的信息无法恢复！<br>确认删除请单击“删除”按钮，取消该操作请单击“取消”按钮。</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="删 除">
        <input type="button" name="is_del" value="取 消" onclick="javascript:history.back(-1);"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>