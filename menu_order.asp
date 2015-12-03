<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/menu.css" rel="stylesheet" type="text/css">
<title></title>
<SCRIPT language=javascript>
function showsubmenu(sid)
{ var i;
whichEl = eval("submenu" + sid);
if (whichEl.style.display == "none")
{ eval("submenu" + sid + ".style.display=\"\";");
  for(i=0;i<4;i++)
  {
    if (i!=sid)
      eval("submenu" + i + ".style.display=\"none\";");
  }
}
else
{
eval("submenu" + sid + ".style.display=\"none\";");
}
}
</SCRIPT>
</head>
<body topmargin=0 leftmargin=0 bgcolor="#5AA8DA">
<table width="140" border="0" cellspacing="0" align=center>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/show_item.asp" target="mainFrame">查看生产项</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="consume_unit/show_item.asp?flag='1'" target="mainFrame">查看单耗</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/list_notify.asp" target="mainFrame">查看生产通知单</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/list_arrange.asp" target="mainFrame">查看生产小组排产表</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/show_day_arrange.asp" target="mainFrame">生产小组日排产表</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/show_day_produce.asp" target="mainFrame">查看生产小组日产</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_day_cut.asp?cut_date=<%=datevalue(now())%>" target="mainFrame">查看裁剪车间日产表</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_day_send.asp?send_date=<%=datevalue(now())%>" target="mainFrame">查看裁剪车间日发活表</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_cut_stat.asp" target="mainFrame">查看完成品统计</td>
  </tr>
</table>
<table width="158" border="0" cellspacing="1" align=center valign=top>
	
<!--订单管理-->
 <DIV style="WIDTH: 158px; top:0px">
<TABLE cellSpacing=1 cellPadding=0 width=158 height="1">                                   
        <TBODY>                                   
        <TR>                                   
          <TD onclick=showsubmenu(0)                                   
            height=25 class=menu><font color="#ffff00" size=2><b>订单管理</b></font>
         </TD>
        </TR>                                   
        <TR>                                   
          <TD id=submenu0 height="1">                                   
            <DIV style="width: 158; height: 100">                                   
            <TABLE height=80 cellSpacing=0 cellPadding=0 width=158 align=center>                                   
              <TBODY>                                
              <tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/input_item.asp" target="mainFrame">新增生产项</a></td>
  						</tr>
  						<tr>
   						 <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/list_item.asp" target="mainFrame">编辑生产项</a></td>
 							</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="consume_unit/show_item.asp" target="mainFrame">计算单耗</a></td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="material_storage/show_item.asp" target="mainFrame">原料入库</a></td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="check_amount/show_item.asp" target="mainFrame">订单核产</a></td>
  						</tr>                                                                                            
              <TR>                                                                                            
          				<SCRIPT language=javascript>                                                                                             
                			eval("submenu0" + ".style.display=\"none\";");                                                                                             
            				</SCRIPT>                                                                                             
        			</TR>
       </TBODY>
	</TABLE> 
</TABLE>
</div>
<!--生产通知单管理--> 
 <DIV style="WIDTH: 158px">   
<TABLE cellSpacing=1 cellPadding=0 width=158 align=center>                                                                                             
        <TBODY>                                                                                             
        <TR>                                                                                             
          <TD onclick=showsubmenu(1)                                                                                          
            height=25 class=menu><font color="#ffff00" size=2><b>生产通知单管理</b></font></TD>
        </TR>                                                                                             
        <TR>                                                                                             
          <TD id=submenu1>                                                                                             
            <DIV style="WIDTH: 158px">                                                                                             
            <TABLE cellSpacing=0 cellPadding=0 width=158 align=center>                                                                                             
              <TBODY>                                                                                             
            <tr>
    					<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/del_useless_notify.asp" target="mainFrame">开生产通知单</td>
  					</tr>
  					<TR>                                                                                                            
                <SCRIPT language=javascript>                                                                                                            
                eval("submenu1" + ".style.display=\"none\";");                                                                                                            
                </SCRIPT>                                                                                                            
             </TR>
             </TBODY>
       </TABLE>
       </div>
 </TABLE>
</div>                                                                                              
<!--生产通管理-->         
 <DIV style="WIDTH: 158px">                                                                                                            
     <TABLE cellSpacing=1 cellPadding=0 width=158 align=center>                                                                                                               
        	<TR>                                                                                                            
          <TD onclick=showsubmenu(2)                                                                                                                                                                                                                      
            height=25 class=menu><font color="#ffff00" size=2><b>生产管理</b></font></TD>
         </TR>                                                                                                            
         <TR>                                                                                                            
          <TD id=submenu2>                                                                                                            
            <DIV style="WIDTH: 158px">                                                                                                                   
            <TABLE cellSpacing=0 cellPadding=0 width=158 align=center>                                                                                                            
              <TBODY>                                                                                                                                
              <tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/del_useless_arrange.asp" target="mainFrame">生产小组排产</td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/edit_arrange.asp" target="mainFrame">停产|延期|增加|减少</td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/list_group.asp" target="mainFrame">上报生产小组日产</td>
  						</tr>
  						<TR>                                                                                                             
                <SCRIPT language=javascript>                                                                                                             
                eval("submenu2" + ".style.display=\"none\";");                                                                                                             
                </SCRIPT>                                                                                                             
              </TR>
              </TBODY>
             </TABLE>
</TABLE>
</DIV> 

<!--裁剪车间生产管理-->    
 <DIV style="width: 158; height: 5">                                                                                                             
     <TABLE cellSpacing=1 cellPadding=0 width=158 align=center>                                                                                                                  
        <TR>                                                                                                             
          <TD onclick=showsubmenu(3)                                                                                                                                                                                                                          
            height=25 class=menu><font color="#ffff00" size=2><b>裁剪车间生产管理</b></font></TD>
        </TR>                                                                                                             
        <TR>                                                                                                             
          <TD id=submenu3>                                                                                                             
            <DIV style="WIDTH: 158px">                                                                                                             
            <TABLE cellSpacing=0 cellPadding=0 width=158 align=center>                                                                                                             
              <TBODY>                                                                                                        
              <tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/list_notify.asp" target="mainFrame">上报裁剪车间日产量</td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/list_arrange.asp" target="mainFrame">上报裁剪车间日发活量</td>
  						</tr>
  						<TR>                                                                                                            
                <SCRIPT language=javascript>                                                                                                            
                eval("submenu3" + ".style.display=\"none\";");                                                                                                            
                </SCRIPT>                                                                                                            
              </TR>
              </TBODY>
            </TABLE>
   </table>
   </DIV>
</table>
</body>
</html>