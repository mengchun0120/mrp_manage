<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="../inc/trans_code.asp"-->
<html>
<head>
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
<table width=100%>
<tr>
<th>�����ţ�</th>
<td><%=rs2("order_no")%></td>
<th>�ͻ����ƣ�</th>
<td><%=rs2("client_name")%></td>
<th>���ڣ�</th>
<td><%=rs2("deliver_date")%></td>
<th>����Ա��</th>
<td><%=rs2("functionary")%></td>
<th>������ڣ�</th>
<td><%=rs2("checkup_date")%></td>
</tr>
</table>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">���ϵ���</td>
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
<th>��������</th>
<th>����</th>
</tr>
<%
j=1
do while(not rss.eof)
set sumtotal1=conn.execute("select sum(total) as t from material_info where consume_id="&rss("consume_id")&" and material_type='����'")
%>
<form method=post action="material_detail.asp"> 
<input type="hidden" name=conid value="<%=rss("consume_id")%>">
<input type="hidden" name=material value="����">
<input type="hidden" name=order value="<%=rss("order_no")%>">
<tr>
<td><%=j%></td>
<td><a href="material_detail.asp?conid=<%=rss("consume_id")%>&material='����'&order=<%=rss("order_no")%>"><%=rss("consume_name")%></td>
<td><%=rss("consume_color")%></td>
<td><%=rss("consume_chengf")%></td>
<td><%=rss("consume_fuk")%></td>
<td><%=rss("consume_danw")%></td>
<td><%=rss("consume_kegyl")%></td>
<td><%=cdbl(rss("consume_shijyl"))+cdbl(rss("consume_sunh"))%></td>
<td><%=rss("consume_sunh")%></td>
<td><%=rss("consume_caijyl")%></td>
<td><%=trans_code(rss("consume_beiz"))%></td>
<td><%=sumtotal1("t")%></td>
<td align=center><input type="submit" name="b" value="���ԭ��"></td>
</tr>
</form>
<%j=j+1
rss.movenext
loop%>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="13">���ϵ���</td>
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
<th>��������</th>
<th>����</th>
</tr>
<%
n=1
do while(not rsl.eof)
set sumtotal2=conn.execute("select sum(total) as t from material_info where consume_id="&rsl("consume_id")&" and material_type='����'")
%>
<form method=post action="material_detail.asp"> 
<input type="hidden" name=conid value="<%=rsl("consume_id")%>">
<input type="hidden" name=material value="����">
<input type="hidden" name=order value="<%=rsl("order_no")%>">
<tr>
<td><%=n%></td>
<td><a href="material_detail.asp?conid=<%=rsl("consume_id")%>&material='����'&order=<%=rsl("order_no")%>"><%=rsl("consume_name")%></td>
<td><%=rsl("consume_color")%></td>
<td><%=rsl("consume_chengf")%></td>
<td><%=rsl("consume_fuk")%></td>
<td><%=rsl("consume_danw")%></td>
<td><%=rsl("consume_kegyl")%></td>
<td><%=cdbl(rsl("consume_shijyl"))+cdbl(rsl("consume_sunh"))%></td>
<td><%=rsl("consume_sunh")%></td>
<td><%=rsl("consume_caijyl")%></td>
<td><%=trans_code(rsl("consume_beiz"))%></td>
<td><%=sumtotal2("t")%></td>
<td align=center><input type="submit" name="b" value="���ԭ��"></td>
</tr>
</form>
<%n=n+1
rsl.movenext
loop%>
</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">���ϵ���</td>
  </tr>	
<tr>
<th>���</th>
<th>����</th>
<th>�ɷ�</th>
<th>���</th>
<th>��λ</th>
<th>����</th>
<th>��ע</th>
<th>��������</th>
<th>����</th>
</tr>
<%
k=1
do while(not rsf.eof)
set sumtotal3=conn.execute("select sum(total) as t from material_info where consume_id="&rsf("consume_id")&" and material_type='����'")
%>
<form method=post action="material_detail.asp"> 
<input type="hidden" name=conid value="<%=rsf("consume_id")%>">
<input type="hidden" name=material value="����">
<input type="hidden" name=order value="<%=rsf("order_no")%>">
<tr>
<td><%=k%></td>
<td><a href="material_detail.asp?conid=<%=rsf("consume_id")%>&material='����'&order=<%=rsf("order_no")%>"><%=rsf("consume_name")%></td>
<td><%=rsf("consume_chengf")%></td>
<td><%=rsf("consume_fuk")%></td>
<td><%=rsf("consume_danw")%></td>
<td><%=rsf("consume_danh")%></td>
<td><%=trans_code(rsf("consume_beiz"))%></td>
<td><%=sumtotal3("t")%></td>
<td align=center><input type="submit" name="b" value="���ԭ��"></td>
</tr>
</form>
<%k=k+1
rsf.movenext
loop%>

</table>

<br>

<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan="12">�����豸������</td>
  </tr>	
<tr>
<th>���</th>
<th>����</th>
<th>���</th>
<th>����</th>
<th>��ע</th>
<th>��������</th>
<th>����</th>
</tr>
<%
m=1
do while(not rsb.eof)
set sumtotal4=conn.execute("select sum(total) as t from material_info where consume_id="&rsb("consume_id")&" and material_type='�豸'")
%>
<form method=post action="material_detail.asp"> 
<input type="hidden" name=conid value="<%=rsb("consume_id")%>">
<input type="hidden" name=material value="�豸">
<input type="hidden" name=order value="<%=rsb("order_no")%>">
<tr>
<td><%=m%></td>
<td><a href="material_detail.asp?conid=<%=rsb("consume_id")%>&material='�豸'&order=<%=rsb("order_no")%>"><%=rsb("consume_name")%></td>
<td><%=rsb("consume_guig")%></td>
<td><%=rsb("consume_shul")%></td>
<td><%=trans_code(rsb("consume_beiz"))%></td>
<td><%=sumtotal4("t")%></td>
<td align=center><input type="submit" name="b" value="���ԭ��"></td>
</tr>
</form>
<%m=m+1
rsb.movenext
loop%>

</table>

</body>
</html>