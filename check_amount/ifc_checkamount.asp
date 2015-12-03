<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<html>
<head>
<script language=javascript>
function calchae(myform){
if ((myform.dingdan.value=="")&&(myform.xuyao.value!=""))
{myform.dingdan.value=myform.xuyao.value/myform.keg.value;
myform.chae.value=myform.daoliao.value-myform.xuyao.value;
 }
else if ((myform.dingdan.value!="")&&(myform.xuyao.value=="")){
        myform.xuyao.value=Math.round(1000*(myform.dingdan.value*myform.keg.value))/1000;
        myform.chae.value=myform.daoliao.value-myform.xuyao.value;
      }
     else
     {
     myform.xuyao.value=Math.round(1000*(myform.dingdan.value*myform.keg.value))/1000;
        myform.chae.value=myform.daoliao.value-myform.xuyao.value;
     }
}
function calch(myform){
if (myform.xuyao.value!="")
{myform.chae.value=myform.daoliao.value-myform.xuyao.value;
 }
 }
</script>
  <link href="../css/global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=0 leftmargin=0>
<%
order=request.querystring("conid")
itemk=request.querystring("kuanid")
if order="" then
	order=request.form("conid")
end if
if itemk="" then
	itemk=request.form("kuanid")
end if


//显示此款订单的基本信息
set rs2=Server.CreateObject("ADODB.Recordset")
sql2="select * from order_info as a1,item_info as a2 where a1.item_id=a2.item_id and a1.order_no='"&order&"'"
rs2.open sql2,conn,1,1


selsql="select * from unitconsume_out where order_no='"&order&"'"
set rss=conn.execute(selsql)

llsql="select * from unitconsume_in where order_no='"&order&"'"
set rsl=conn.execute(llsql)

flsql="select * from unitconsume_other where order_no='"&order&"'"
set rsf=conn.execute(flsql)

sbsql="select * from unitconsume_equipment where order_no='"&order&"'"
set rsb=conn.execute(sbsql)
%>
<table width=100%>
<tr>
<th>订单号：</th>
<td><%=rs2("order_no")%></td>
<th>客户名称：</th>
<td><%=rs2("client_name")%></td>
<th>货期：</th>
<td><%=rs2("deliver_date")%></td>
<th>跟单员：</th>
<td><%=rs2("functionary")%></td>
<th>验货日期：</th>
<td><%=rs2("checkup_date")%></td>
</tr>
</table>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="14">面料单耗</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>颜色</th>
<th>成份</th>
<th>幅宽</th>
<th>单位</th>
<th>客供用率</th>
<th>订单加工数量</th>
<th>需要数量</th>
<th>到料数量</th>
<th>能加工数量</th>
<th>差额（米）</th>
<th>核产结果</th>
<th>备注</th>
</tr>
<%
j=1
ff=1
do while(not rss.eof)
set sumtotal1=conn.execute("select sum(total) as t from material_info where consume_id="&rss("consume_id")&" and material_type='面料'")
set checkout=conn.execute("select * from checkamount_info where consume_id='"&rss("consume_id")&"' and consume_type='面料'")
if not checkout.eof then
    cojs=checkout("jiagjs")
    cosl=checkout("xuysl")
    codl=sumtotal1("t")-cosl
else
    cojs="无"
    cosl="无"
    codl="无"
end if
%>
<form name=myform<%=ff%> method=post action="check_amount.asp"> 
<input type="hidden" name=conid value="<%=rss("consume_id")%>">
<input type="hidden" name=material value="面料">
<input type="hidden" name=keg value="<%=rss("consume_kegyl")%>">
<input type="hidden" name=daoliao value="<%=sumtotal1("t")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=j%></td>
<td><%=rss("consume_name")%></td>
<td><%=rss("consume_color")%></td>
<td><%=rss("consume_chengf")%></td>
<td><%=rss("consume_fuk")%></td>
<td><%=rss("consume_danw")%></td>
<td><%=rss("consume_kegyl")%></td>
<td><input type=text name=dingdan size=5 value="<%=cojs%>" onchange="calchae(myform<%=ff%>)"></td>
<td><input type=text name=xuyao size=5 value="<%=cosl%>" onchange="calchae(myform<%=ff%>)"></td>
<td><%=sumtotal1("t")%></td>
<td><%=round(sumtotal1("t")/rss("consume_kegyl"))%></td>
<td><input type=text name=chae size=10 value="<%=codl%>"></td>
<%if not checkout.eof then%>
<td align=center><input type="submit" name="hechan" value="通过"></td>
<%else%>
<td align=center><input type="submit" name="hechan" value="核产"></td>
<%end if%>
<td><%=trans_code(rss("consume_beiz"))%></td>

</tr>
</form>
<%j=j+1
ff=ff+1
rss.movenext
loop%>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="14">里料单耗</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>颜色</th>
<th>成份</th>
<th>幅宽</th>
<th>单位</th>
<th>客供用率</th>
<th>订单加工数量</th>
<th>需要数量</th>
<th>到料数量</th>
<th>能加工数量</th>
<th>差额（米）</th>
<th>核产结果</th>
<th>备注</th>
</tr>
<%
n=1
do while(not rsl.eof)
set sumtotal2=conn.execute("select sum(total) as t from material_info where consume_id="&rsl("consume_id")&" and material_type='里料'")
set checkin=conn.execute("select * from checkamount_info where consume_id='"&rsl("consume_id")&"' and consume_type='里料'")
if not checkin.eof then
    cijs=checkin("jiagjs")
    cisl=checkin("xuysl")
    cidl=sumtotal2("t")-cisl
else
    cijs="无"
    cisl="无"
    cidl="无"
end if
%>
<form name=myform<%=ff%> method=post action="check_amount.asp"> 
<input type="hidden" name=conid value="<%=rsl("consume_id")%>">
<input type="hidden" name=material value="里料">
<input type="hidden" name=keg value="<%=rsl("consume_kegyl")%>">
<input type="hidden" name=daoliao value="<%=sumtotal2("t")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=n%></td>
<td><%=rsl("consume_name")%></td>
<td><%=rsl("consume_color")%></td>
<td><%=rsl("consume_chengf")%></td>
<td><%=rsl("consume_fuk")%></td>
<td><%=rsl("consume_danw")%></td>
<td><%=rsl("consume_kegyl")%></td>
<td><input type=text name=dingdan size=5 value="<%=cijs%>" onchange="calchae(myform<%=ff%>)"></td>
<td><input type=text name=xuyao size=5 value="<%=cisl%>" onchange="calchae(myform<%=ff%>)"></td>
<td><%=sumtotal2("t")%></td>
<td><%=round(sumtotal2("t")/rsl("consume_kegyl"))%></td>
<td><input type=text name=chae size=10 value="<%=cidl%>"></td>
<%if not checkin.eof then%>
<td align=center><input type="submit" name="hechan" value="通过"></td>
<%else%>
<td align=center><input type="submit" name="hechan" value="核产"></td>
<%end if%>
<td><%=trans_code(rsl("consume_beiz"))%></td>
</tr>
</form>
<%n=n+1
ff=ff+1
rsl.movenext
loop%>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">辅料单耗</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>成份</th>
<th>规格</th>
<th>单位</th>
<th>单耗</th>
<th>订单加工数量</th>
<th>需要数量</th>
<th>到货总量</th>
<th>差额</th>
<th>核产结果</th>
<th>备注</th>
</tr>
<%
k=1
do while(not rsf.eof)
set sumtotal3=conn.execute("select sum(total) as t from material_info where consume_id="&rsf("consume_id")&" and material_type='辅料'")
set checkf=conn.execute("select * from checkamount_info where consume_id='"&rsf("consume_id")&"' and consume_type='辅料'")
if not checkf.eof then
    cfjs=checkf("jiagjs")
    cfsl=checkf("xuysl")
    cfdl=sumtotal3("t")-cfsl
else
    cfjs="无"
    cfsl="无"
    cfdl="无"
end if
%>
<form name=myform<%=ff%> method=post action="check_amount.asp"> 
<input type="hidden" name=conid value="<%=rsf("consume_id")%>">
<input type="hidden" name=material value="辅料">
<input type="hidden" name=keg value="<%=rsf("consume_danh")%>">
<input type="hidden" name=daoliao value="<%=sumtotal3("t")%>">
<input type="hidden" name=order value="<%=order%>">

<tr>
<td><%=k%></td>
<td><%=rsf("consume_name")%></td>
<td><%=rsf("consume_chengf")%></td>
<td><%=rsf("consume_fuk")%></td>
<td><%=rsf("consume_danw")%></td>
<td><%=rsf("consume_danh")%></td>
<td><input type=text name=dingdan size=5 value="<%=cfjs%>" onchange="calchae(myform<%=ff%>)"></td>
<td><input type=text name=xuyao size=5 value="<%=cfsl%>" onchange="calchae(myform<%=ff%>)"></td>
<td><%=sumtotal3("t")%></td>
<td><input type=text name=chae size=10 value="<%=cfdl%>"></td>
<%if not checkf.eof then%>
<td align=center><input type="submit" name="hechan" value="通过"></td>
<%else%>
<td align=center><input type="submit" name="hechan" value="核产"></td>
<%end if%>
<td><%=trans_code(rsf("consume_beiz"))%></td>
</tr>
</form>
<%k=k+1
ff=ff+1
rsf.movenext
loop%>

</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">特殊设备及工具</td>
  </tr>	
<tr>
<th>序号</th>
<th>名称</th>
<th>规格</th>
<th>数量</th>
<th>需要数量</th>
<th>到货总量</th>
<th>差额</th>
<th>核产结果</th>
<th>备注</th>
</tr>
<%
m=1
do while(not rsb.eof)
set sumtotal4=conn.execute("select sum(total) as t from material_info where consume_id="&rsb("consume_id")&" and material_type='设备'")
set checkb=conn.execute("select * from checkamount_info where consume_id='"&rsb("consume_id")&"' and consume_type='设备'")
if not checkb.eof then
    cbsl=checkb("xuysl")
    cbdl=sumtotal4("t")-cbsl
else
    cbsl="无"
    cbdl="无"
end if
%>
<form name=myform<%=ff%> method=post action="check_amount.asp"> 
<input type="hidden" name=conid value="<%=rsb("consume_id")%>">
<input type="hidden" name=material value="设备">
<input type="hidden" name=daoliao value="<%=sumtotal4("t")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=m%></td>
<td><%=rsb("consume_name")%></td>
<td><%=rsb("consume_guig")%></td>
<td><%=rsb("consume_shul")%></td>
<td><input type=text size=5 name=xuyao value="<%=cbsl%>" onchange="calch(myform<%=ff%>)"></td>
<td><%=sumtotal4("t")%></td>
<td><input type=text size=5 name=chae value="<%=cbdl%>"></td>
<%if not checkb.eof then%>
<td align=center><input type="submit" name="hechan" value="通过"></td>
<%else%>
<td align=center><input type="submit" name="hechan" value="核产"></td>
<%end if%>
<td><%=trans_code(rsb("consume_beiz"))%></td>
</tr>
</form>
<%m=m+1
ff=ff+1
rsb.movenext
loop%>
</table>
</body>
</html>