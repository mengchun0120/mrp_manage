<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<html>
	<head>
		<script language=javascript>
			function calcaijian(myform){
				if ((myform.sj.value!="")&&(myform.sh.value!=""))
				      {myform.cj.value=Math.round(1000*(myform.sj.value*(1+myform.sh.value/100)))/1000;
				       myform.kg.value=myform.cj.value;}
				}
		</script>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
<body topmargin=0 leftmargin=0>
<%
order=request("conid")
itemk=request("kuanid")

if itemk<>"" then
	session("itemk")=itemk
end if

//��ʾ�˿���Ļ�����Ϣ
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
<table width=100%><tr><th>
�����ţ�</th><td><%=rs2("order_no")%></td><th>�ͻ����ƣ�</th><td><%=rs2("client_name")%></td><th>���ڣ�</th><td><%=rs2("deliver_date")%></td><th>����Ա��</th><td><%=rs2("functionary")%></td><th>������ڣ�</th><td><%=rs2("checkup_date")%></td></tr>
</table>



<%

set rsc=Server.CreateObject("ADODB.Recordset")
sqlc="select top 2 * from order_info where item_id='"&itemk&"' and consume_date<>'' order by consume_date desc"

rsc.open sqlc,conn,1,1
while not rsc.eof

  if (rsc("state")<>"¼��" and rsc("order_no")<>order) then
  serial_no=serial_no+1
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="select sum(suborder_amount) from suborder_info where order_no='"&rs2("order_no")&"'"
  rs3.open sql3,conn,1,1
    amount=rs3(0)
  all_amount=all_amount+cint(amount)
  rs3.close
  set rs3=nothing
%>
<table width="100%" cellspacing=1>
  <tr>
    <th>���</th>
    <th>������ PO.NO</th>
    <th>ULT.DEST</th>
    <th>BR/PL</th>
    <th>����</th>
    <th>������</th>
    <th>����</th>
    <th>Ŀ�ĵ�</th>
    <th>�������</th>
    <th>��������</th>
    <th>Ԥ�Ƶ�������</th>
    <th>�ر�ͻ�</th>
    <th>����</th>
  </tr>
  <tr>
    <th><%=serial_no%></th>
    <td align="center"><%=rsc("order_no")%></td>
    <td align="center"><%=rsc("ult_dest")%></td>
    <td align="center"><%=rsc("br_pl")%></td>
    <td align="center"><%=rsc("area")%></td>
    <td align="center"><%=rsc("chest_no")%></td>
    <td align="center"><%=amount%></td>
    <td align="center"><%=rsc("destination")%></td>
    <td align="center"><%=rsc("checkup_date")%></td>
    <td align="center"><%=rsc("deliver_date")%></td>
    <td align="center"><%=rsc("material_date")%></td>
    <td align="center"><%=rsc("special_client")%></td>
    <form action="show_dhjs.asp" method=post target="mainFrame">
     <input type="hidden" name="conid" value="<%=rsc("order_no")%>">
     <input type="hidden" name="kuanid" value="<%=itemk%>">
     <input type="hidden" name="cz" value="cz">
     <input type="hidden" name="neworder" value="<%=order%>">
     <th align="center"><input type="submit" value="�鿴����"></th>
    </form>
    
  </tr>
<%end if
	  rsc.movenext
	wend
%>
</tr>
</table>




<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">�������ϵ���</td>
  </tr>	
<tr>
<th>���</th>
<th>����</th>
<th>��ɫ</th>
<th>�ɷ�</th>
<th>����</th>
<th>��λ</th>
<th>�͹�����</th>
<th>ʵ������</th>
<th>���</th>
<th>�ü�����</th>
<th>��ע</th>
<th>����</th>
</tr>
<%
j=1
do while(not rss.eof)%>
<form method=post action="out_update_dhjs.asp"> 
<input type="hidden" name=conid value="<%=rss("consume_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=j%></td>
<td><a href=out_update_dhjs.asp?conid=<%=rss("consume_id")%>&order=<%=order%>><%=rss("consume_name")%></td>
<td><%=rss("consume_color")%></td>
<td><%=rss("consume_chengf")%></td>
<td><%=rss("consume_fuk")%></td>
<td><%=rss("consume_danw")%></td>
<td><%=rss("consume_kegyl")%></td>
<td><%=cdbl(rss("consume_shijyl"))+cdbl(rss("consume_sunh"))%></td>
<td><%=rss("consume_sunh")%></td>
<td><%=rss("consume_caijyl")%></td>
<td><%=trans_code(rss("consume_beiz"))%></td>
<td><input type="submit" name="b" value="�޸�"><input name="conid" type="button" onclick="MM_goToURL('self','out_ifcdele_dhjs.asp?conid=<%=rss("consume_id")%>&order=<%=order%>');return document.MM_returnValue" value="ɾ��"></td>
</tr>
</form>
<%j=j+1
rss.movenext
loop%>
<form name=myform1 method=post action="out_add_dhjs.asp">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td>&nbsp;</td>
<td><input type="text" name="mc" size=10></td>
<td><input type="text" name="ys" size=10></td>
<td><input type="text" name="cf" size=10></td>
<td><input type="text" name="fk" size=5></td>
<td><input type="text" name="dw" size=5></td>
<td><input type="text" name="kg" size=5></td>
<td><input type="text" name="sj" size=5></td>
<td><input type="text" name="sh" size=5 onchange="calcaijian(myform1)"></td>
<td><input type="text" name="cj" size=5></td>
<td><textarea name="bz" cols="12"></textarea></td>
<td><input type="submit" name="b" value="���"></td>
</tr>
</form>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">�������ϵ���</td>
  </tr>	
<tr>
<th>���</th>
<th>����</th>
<th>��ɫ</th>
<th>�ɷ�</th>
<th>����</th>
<th>��λ</th>
<th>�͹�����</th>
<th>ʵ������</th>
<th>���</th>
<th>�ü�����</th>
<th>��ע</th>
<th>����</th>
</tr>
<%
n=1
do while(not rsl.eof)%>
<form method=post action="in_update_dhjs.asp"> 
<input type="hidden" name=conid value="<%=rsl("consume_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=n%></td>
<td><a href="in_update_dhjs.asp?conid=<%=rsl("consume_id")%>&order=<%=order%>"><%=rsl("consume_name")%></td>
<td><%=rsl("consume_color")%></td>
<td><%=rsl("consume_chengf")%></td>
<td><%=rsl("consume_fuk")%></td>
<td><%=rsl("consume_danw")%></td>
<td><%=rsl("consume_kegyl")%></td>
<td><%=cdbl(rsl("consume_shijyl"))+cdbl(rsl("consume_sunh"))%></td>
<td><%=rsl("consume_sunh")%></td>
<td><%=rsl("consume_caijyl")%></td>
<td><%=trans_code(rsl("consume_beiz"))%></td>
<td><input type="submit" name="b" value="�޸�"><input name="conid" type="button" onclick="MM_goToURL('self','in_ifcdele_dhjs.asp?conid=<%=rsl("consume_id")%>&order=<%=order%>');return document.MM_returnValue" value="ɾ��"></td>
</tr>
</form>
<%n=n+1
rsl.movenext
loop%>
<form name=myform2 method=post action="in_add_dhjs.asp">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td>&nbsp;</td>
<td><input type="text" name="mc" size=10></td>
<td><input type="text" name="ys" size=10></td>
<td><input type="text" name="cf" size=10></td>
<td><input type="text" name="fk" size=5></td>
<td><input type="text" name="dw" size=5></td>
<td><input type="text" name="kg" size=5></td>
<td><input type="text" name="sj" size=5></td>
<td><input type="text" name="sh" size=5 onchange="calcaijian(myform2)"></td>
<td><input type="text" name="cj" size=5></td>
<td><textarea name="bz" cols="12"></textarea></td>
<td><input type="submit" name="b" value="���"></td>
</tr>
</form>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">���Ӹ��ϵ���</td>
  </tr>	
<tr>
<th>���</th>
<th>����</th>
<th>�ɷ�</th>
<th>���</th>
<th>��λ</th>
<th>����</th>
<th>��ע</th>
<th>����</th>
</tr>
<%
k=1
do while(not rsf.eof)%>
<form method=post action="other_update_dhjs.asp"> 
<input type="hidden" name=conid value="<%=rsf("consume_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=k%></td>
<td><a href="other_update_dhjs.asp?conid=<%=rsf("consume_id")%>&order=<%=order%>"><%=rsf("consume_name")%></td>
<td><%=rsf("consume_chengf")%></td>
<td><%=rsf("consume_fuk")%></td>
<td><%=rsf("consume_danw")%></td>
<td><%=rsf("consume_danh")%></td>
<td><%=trans_code(rsf("consume_beiz"))%></td>
<td><input type="submit" name="b" value="�޸�"><input name="conid" type="button" onclick="MM_goToURL('self','other_ifcdele_dhjs.asp?conid=<%=rsf("consume_id")%>&order=<%=order%>');return document.MM_returnValue" value="ɾ��"></td>
</tr>
</form>
<%k=k+1
rsf.movenext
loop%>
<form name=myform3 method=post action="other_add_dhjs.asp">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td>&nbsp;</td>
<td><input type="text" name="mc" size=20></td>
<td><input type="text" name="cf" size=20></td>
<td><input type="text" name="fk" size=5></td>
<td><input type="text" name="dw" size=5></td>
<td><input type="text" name="cj" size=5></td>
<td><textarea name="bz" cols="20"></textarea></td>
<td><input type="submit" name="b" value="���"></td>
</tr>
</form>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">���������豸������</td>
  </tr>	
<tr>
<th>���</th>
<th>����</th>
<th>���</th>
<th>����</th>
<th>��ע</th>
<th>����</th>
</tr>
<%
m=1
do while(not rsb.eof)%>
<form method=post action="equip_update_dhjs.asp"> 
<input type="hidden" name=conid value="<%=rsb("consume_id")%>">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td><%=m%></td>
<td><a href="equip_update_dhjs.asp?conid=<%=rsb("consume_id")%>&order=<%=order%>"><%=rsb("consume_name")%></td>
<td><%=rsb("consume_guig")%></td>
<td><%=rsb("consume_shul")%></td>
<td><%=trans_code(rsb("consume_beiz"))%></td>
<td><input type="submit" name="b" value="�޸�"><input name="conid" type="button" onclick="MM_goToURL('self','equip_ifcdele_dhjs.asp?conid=<%=rsb("consume_id")%>&order=<%=order%>');return document.MM_returnValue" value="ɾ��"></td>
</tr>
</form>
<%m=m+1
rsb.movenext
loop%>
<form name=myform4 method=post action="equip_add_dhjs.asp">
<input type="hidden" name=order value="<%=order%>">
<tr>
<td>&nbsp;</td>
<td><input type="text" name="mc" size=20></td>
<td><input type="text" name="gg" size=20></td>
<td><input type="text" name="sl" size=5></td>
<td><textarea name="bz" cols="30"></textarea></td>
<td><input type="submit" name="b" value="���"></td>
</tr>
</form>
</table>
<center><form action=confirm_dhjs.asp method=post>
	<input type="hidden" name="conid" value="<%=order%>">
  <input type="submit" value="ȷ�ϵ��ļ������">
</form></center>
</body>
</html>