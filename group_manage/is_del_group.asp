<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
group_name=trim(request("group_name"))
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
  		<form action="del_group.asp" method=post target="mainFrame">
  		<input type="hidden" name="group_name" value="<%=group_name%>">
      <tr>
        <td>ȷ��Ҫɾ������С�顰<%=group_name%>����<br>ȷ��ɾ���뵥����ɾ������ť��ȡ���ò����뵥����ȡ������ť��</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="ɾ ��">
        <input type="submit" name="is_del" value="ȡ ��"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>