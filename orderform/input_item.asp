<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<!--#include file="inc/check_user.asp"-->
<%
'以下7个数据均用于回显功能
client_name=trim(request("client_name"))
design_no=trim(request("design_no"))
product_name=trim(request("product_name"))
affix_date=trim(request("affix_date"))
man_hour=trim(request("man_hour"))
description=trim(request("description"))
remark=trim(request("remark"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<form action="add_item.asp" method=post target="mainFrame">
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="4">录入生产项基本信息</td>
  </tr>
  <tr>
  	<th width="15%">客户名称：</th>
    <td width="35%"><input type="text" name="client_name" maxlength="25" value="<%=client_name%>"> （少于25字）</td>
    <th width="15%">跟 单 员：</th>
    <td width="35%"><%=session("username")%><!--<input type="text" name="functionary" maxlength="5"> （少于5字）--></td>
  </tr>
  <tr>
    <th>款 &nbsp;&nbsp;&nbsp;号：</th>
    <td><input type="text" name="design_no" maxlength="25" value="<%=design_no%>"> （少于25字）</td>
    <th>产品名称：</th>
    <td><input type="text" name="product_name" maxlength="50" value="<%=product_name%>"> （少于50字）</td>
  </tr>
  <tr>
    <th>签单日期：</th>
    <td><input type="text" name="affix_date" maxlength="10" <%if affix_date="" then %>value="<%=datevalue(now())%>"<% else %> value="<%=affix_date%>"<%end if%>> （格式：YYYY-MM-DD）</td>
    <th>工 &nbsp;&nbsp;&nbsp;时：</th>
    <td><input type="text" name="man_hour" maxlength="10" value="<%=man_hour%>"> 秒（格式：数字）</td>
  </tr>
  <tr>
    <th>描 &nbsp;&nbsp;&nbsp;述：</th>
    <td colspan=3><input type="text" name="description" size=80 maxlength="100" value="<%=description%>">  （少于100字）</td>
  </tr>
  <tr>
    <th>备 &nbsp;&nbsp;&nbsp;注：</th>
    <td colspan=3><textarea name="remark" cols=79 rows=4><%=remark%></textarea></td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="提 交"> <input type="reset" value="重 置"></th>
  </tr>
</table>
</form>
</body>
</html>