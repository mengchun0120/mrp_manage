<!--#include file="inc/fun.asp"-->
<%
errmsg=trim(request("errmsg"))
return_yes=trim(request("return_yes"))
return_no=trim(request("return_no"))
%>
<html>
	<head>
		<title>�зı��ط�װ���޹�˾MRPII��������ϵͳ</title>
    <link href="css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=0>
  		<tr>
  			<td class="table_title" colspan=2>Ҫ��ȷ��</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%><%=return_url%></td>
  		</tr>
  		<tr>
  			<th>
			    <input name="Submit" type="button" onclick="MM_goToURL('self','<%=return_yes%>');return document.MM_returnValue" value="  ��  ">&nbsp;&nbsp;
			    <input name="Submit" type="button" onclick="MM_goToURL('self','<%=return_no%>');return document.MM_returnValue" value="  ��  ">
		    </th>
  		</tr>
  	</table>
  </body>
</html>