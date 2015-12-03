<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/menu.css" rel="stylesheet" type="text/css">
<title></title>

</head>
<body topmargin=0 leftmargin=0 bgcolor="#5AA8DA">
<table width="140" border="0" cellspacing="1" align=center>
  <!--<tr height=25>
    <th>订单管理</th>
  </tr>-->
  <tr>
    <td><font color="#ffff00" size=2><b>订单管理</b></font></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/input_item.asp" target="mainFrame">新增生产项</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/list_item.asp" target="mainFrame">编辑生产项</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/show_item.asp" target="mainFrame">查看生产项</a></td>
  </tr>
  <!--<tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="input_order.asp" target="mainFrame">新增订单</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="edit_order.asp" target="mainFrame">编辑订单</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="show_order.asp" target="mainFrame">查看订单</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''">订单加耗</td>
  </tr>-->
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="consume_unit/show_item.asp" target="mainFrame">计算单耗</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="consume_unit/show_item.asp?flag='1'" target="mainFrame">显示单耗</a></td>
  </tr>
    <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="material_storage/show_item.asp" target="mainFrame">原料入库</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="check_amount/show_item.asp" target="mainFrame">订单核产</a></td>
  </tr>
  <!--<tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''">置订单完成状态</td>
  </tr>-->
  <tr>
    <td><font color="#ffff00" size=2><b>生产通知单管理</b></font></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/del_useless_notify.asp" target="mainFrame">开生产通知单</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/list_notify.asp" target="mainFrame">查看生产通知单</td>
  </tr>
  <!--<tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/list_useless_notify.asp" target="mainFrame">删除无效生产通知单</td>
  </tr>-->
  <tr>
    <td><font color="#ffff00" size=2><b>生产管理</b></font></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/del_useless_arrange.asp" target="mainFrame">生产小组排产</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/edit_arrange.asp" target="mainFrame">停产|延期|增加|减少</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/list_arrange.asp" target="mainFrame">查看生产小组排产表</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/show_day_arrange.asp" target="mainFrame">生产小组日排产表</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/list_group.asp" target="mainFrame">上报生产小组日产</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/show_day_produce.asp" target="mainFrame">查看生产小组日产</td>
  </tr>
  <tr>
    <td><font color="#ffff00" size=2><b>裁剪车间生产管理</b></font></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/list_notify.asp" target="mainFrame">上报裁剪车间日产量</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_day_cut.asp?cut_date=<%=datevalue(now())%>" target="mainFrame">查看裁剪车间日产表</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/list_arrange.asp" target="mainFrame">上报裁剪车间日发活量</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_day_send.asp?send_date=<%=datevalue(now())%>" target="mainFrame">查看裁剪车间日发活表</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_cut_stat.asp" target="mainFrame">查看完成品统计</td>
  </tr>
</table>
</body>
</html>