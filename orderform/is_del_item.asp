<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
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
  			<td class="table_title" colspan=2>�Ƿ�ɾ��</td>
  		</tr>
  		<form action="del_item.asp" method=post target="mainFrame">
      <tr>
        <input type="hidden" name="item_id" value="<%=item_id%>">
        <input type="hidden" name="goto_url" value="<%=goto_url%>">
        <td>���ɾ���������������������Ϣ�Լ������������ж����Ͷ�������ϢҲ��һ��ɾ������������ɾ������Ϣ�޷��ָ���<br>ȷ��ɾ���뵥����ɾ������ť��ȡ���ò����뵥����ȡ������ť��</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="ɾ ��">
        <input type="submit" name="is_del" value="ȡ ��"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>