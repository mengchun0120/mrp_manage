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
  			<td class="table_title" colspan=2>�Ƿ�ͣ��</td>
  		</tr>
  		<form action="stop_product.asp" method=post target="mainFrame">
  		<input type="hidden" name="arrange_no" value="<%=arrange_no%>">
  		<input type="hidden" name="arrange_group" value="<%=arrange_group%>">
      <tr>
        <td>ȷ��Ҫͣ����<br>ȷ��ͣ���뵥����ͣ������ť��ȡ���ò����뵥����ȡ������ť��</td>
      </tr>
      <tr>
        <th align="center"><input type="submit" name="is_del" value="ͣ ��">
        <input type="submit" name="is_del" value="ȡ ��"></th>
      </form>
      </tr>
  	</table>
  </body>
</html>