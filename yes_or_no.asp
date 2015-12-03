<!--#include file="inc/fun.asp"-->
<%
errmsg=trim(request("errmsg"))
return_yes=trim(request("return_yes"))
return_no=trim(request("return_no"))
%>
<html>
	<head>
		<title>中纺宝特服装有限公司MRPII生产管理系统</title>
    <link href="css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=0>
  		<tr>
  			<td class="table_title" colspan=2>要求确认</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%><%=return_url%></td>
  		</tr>
  		<tr>
  			<th>
			    <input name="Submit" type="button" onclick="MM_goToURL('self','<%=return_yes%>');return document.MM_returnValue" value="  是  ">&nbsp;&nbsp;
			    <input name="Submit" type="button" onclick="MM_goToURL('self','<%=return_no%>');return document.MM_returnValue" value="  否  ">
		    </th>
  		</tr>
  	</table>
  </body>
</html>