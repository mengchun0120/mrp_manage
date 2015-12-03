<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="inc/check_depart.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<br><br><br><br><br>
<div align=center>
<form action="add_group.asp" method=post target="mainFrame">
<table width="50%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="2">录入生产小组信息</td>
  </tr>
  <tr>
  	<th width="30%">生产小组名称：</th>
    <td width="70%"><input type="text" name="group_name" maxlength="25"> （少于25字）</td>
  </tr>
  <tr>
    <th colspan="4" align="center"><input type="submit" value="提 交"> <input type="reset" value="重 置"></th>
  </tr>
</table>
</form>
</div>
</body>
</html>