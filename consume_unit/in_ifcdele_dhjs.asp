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
  			<td class="table_title" colspan=2>�Ƿ�ɾ��</td>
  		</tr>
  		<form action="in_del_dhjs.asp" method=post>
      <tr>
        <input type="hidden" name="conid" value="<%=conid%>">
        <input type="hidden" name=order value="<%=order%>">
        <td>���ɾ�������������Ϣ�Լ���������������ϢҲ��һ��ɾ������������ɾ������Ϣ�޷��ָ���<br>ȷ��ɾ���뵥����ɾ������ť��ȡ���ò����뵥����ȡ������ť��</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="ɾ ��">
        <input type="button" name="is_del" value="ȡ ��" onclick="javascript:history.back(-1);"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>