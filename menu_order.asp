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
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/show_item.asp" target="mainFrame">�鿴������</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="consume_unit/show_item.asp?flag='1'" target="mainFrame">�鿴����</a></td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/list_notify.asp" target="mainFrame">�鿴����֪ͨ��</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/list_arrange.asp" target="mainFrame">�鿴����С���Ų���</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/show_day_arrange.asp" target="mainFrame">����С�����Ų���</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/show_day_produce.asp" target="mainFrame">�鿴����С���ղ�</td>
  </tr>
  <tr>
    <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_day_cut.asp?cut_date=<%=datevalue(now())%>" target="mainFrame">�鿴�ü������ղ���</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_day_send.asp?send_date=<%=datevalue(now())%>" target="mainFrame">�鿴�ü������շ����</td>
  </tr>
  <tr>
  	<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/show_cut_stat.asp" target="mainFrame">�鿴���Ʒͳ��</td>
  </tr>
</table>
<table width="158" border="0" cellspacing="1" align=center valign=top>
	
<!--��������-->
 <DIV style="WIDTH: 158px; top:0px">
<TABLE cellSpacing=1 cellPadding=0 width=158 height="1">                                   
        <TBODY>                                   
        <TR>                                   
          <TD onclick=showsubmenu(0)                                   
            height=25 class=menu><font color="#ffff00" size=2><b>��������</b></font>
         </TD>
        </TR>                                   
        <TR>                                   
          <TD id=submenu0 height="1">                                   
            <DIV style="width: 158; height: 100">                                   
            <TABLE height=80 cellSpacing=0 cellPadding=0 width=158 align=center>                                   
              <TBODY>                                
              <tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/input_item.asp" target="mainFrame">����������</a></td>
  						</tr>
  						<tr>
   						 <td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="orderform/list_item.asp" target="mainFrame">�༭������</a></td>
 							</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="consume_unit/show_item.asp" target="mainFrame">���㵥��</a></td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="material_storage/show_item.asp" target="mainFrame">ԭ�����</a></td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="check_amount/show_item.asp" target="mainFrame">�����˲�</a></td>
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
<!--����֪ͨ������--> 
 <DIV style="WIDTH: 158px">   
<TABLE cellSpacing=1 cellPadding=0 width=158 align=center>                                                                                             
        <TBODY>                                                                                             
        <TR>                                                                                             
          <TD onclick=showsubmenu(1)                                                                                          
            height=25 class=menu><font color="#ffff00" size=2><b>����֪ͨ������</b></font></TD>
        </TR>                                                                                             
        <TR>                                                                                             
          <TD id=submenu1>                                                                                             
            <DIV style="WIDTH: 158px">                                                                                             
            <TABLE cellSpacing=0 cellPadding=0 width=158 align=center>                                                                                             
              <TBODY>                                                                                             
            <tr>
    					<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="produce_notify/del_useless_notify.asp" target="mainFrame">������֪ͨ��</td>
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
<!--����ͨ����-->         
 <DIV style="WIDTH: 158px">                                                                                                            
     <TABLE cellSpacing=1 cellPadding=0 width=158 align=center>                                                                                                               
        	<TR>                                                                                                            
          <TD onclick=showsubmenu(2)                                                                                                                                                                                                                      
            height=25 class=menu><font color="#ffff00" size=2><b>��������</b></font></TD>
         </TR>                                                                                                            
         <TR>                                                                                                            
          <TD id=submenu2>                                                                                                            
            <DIV style="WIDTH: 158px">                                                                                                                   
            <TABLE cellSpacing=0 cellPadding=0 width=158 align=center>                                                                                                            
              <TBODY>                                                                                                                                
              <tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/del_useless_arrange.asp" target="mainFrame">����С���Ų�</td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="arrange_produce/edit_arrange.asp" target="mainFrame">ͣ��|����|����|����</td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="day_produce/list_group.asp" target="mainFrame">�ϱ�����С���ղ�</td>
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

<!--�ü�������������-->    
 <DIV style="width: 158; height: 5">                                                                                                             
     <TABLE cellSpacing=1 cellPadding=0 width=158 align=center>                                                                                                                  
        <TR>                                                                                                             
          <TD onclick=showsubmenu(3)                                                                                                                                                                                                                          
            height=25 class=menu><font color="#ffff00" size=2><b>�ü�������������</b></font></TD>
        </TR>                                                                                                             
        <TR>                                                                                                             
          <TD id=submenu3>                                                                                                             
            <DIV style="WIDTH: 158px">                                                                                                             
            <TABLE cellSpacing=0 cellPadding=0 width=158 align=center>                                                                                                             
              <TBODY>                                                                                                        
              <tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/list_notify.asp" target="mainFrame">�ϱ��ü������ղ���</td>
  						</tr>
  						<tr>
    						<td onMouseOver="this.style.backgroundColor='#7AB7DF'" onMouseOut ="this.style.backgroundColor=''"><a href="cut_send/list_arrange.asp" target="mainFrame">�ϱ��ü������շ�����</td>
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