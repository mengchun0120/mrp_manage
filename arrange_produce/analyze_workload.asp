<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/user_timeout.asp"-->
<!--#include file="../inc/fun.asp"-->
<!--#include file="inc/check_depart.asp"-->
<%
on error resume next
date_start=trim(request.form("date_start"))
date_finish=trim(request.form("date_finish"))
work_time=trim(request.form("work_time"))
arrange_amount=trim(request.form("arrange_amount"))
suborder_color=trim(request.form("suborder_color"))
suborder_size=trim(request.form("suborder_size"))
notify_no=trim(request.form("notify_no"))
arrange_group=trim(request.form("arrange_group"))
arrange_no=trim(request.form("arrange_no"))
design_no=trim(request.form("design_no"))

suborder_color_arr=split(suborder_color,",")
suborder_size_arr=split(suborder_size,",")
arrange_amount_arr=split(arrange_amount,",")

if date_start="" or date_finish="" or work_time="" then
	errmsg="����ʼ���ڡ������������ڡ��͡�ÿ�չ���ʱ����������Ϊ�գ���������д��" 
	time_out=2
	return_url="input_arrange.asp?notify_no="&notify_no&"&design_no="&design_no&"&arrange_no="&arrange_no&"&arrange_group="&arrange_group&"&date_start="&date_start&"&date_finish="&date_finish&"&work_time="&work_time
elseif isdate(date_start)=0 or isdate(date_finish)=0 then
	errmsg="����д��������Ч����������д��"
	time_out=1
	return_url="input_arrange.asp?notify_no="&notify_no&"&design_no="&design_no&"&arrange_no="&arrange_no&"&arrange_group="&arrange_group&"&date_start="&date_start&"&date_finish="&date_finish&"&work_time="&work_time
else
	'��׼��������
	this_arrange_amount_sum=0
  '�õ����θ�С��Ҫ�Ų��������ܺ�
  for i=0 to ubound(suborder_color_arr)
    this_arrange_amount_sum=this_arrange_amount_sum+cint(trim(arrange_amount_arr(i)))
  next
  '�õ���С����Ų����Ѿ����ŵ��Ų����������ϱ��θ�С��Ҫ�Ų��������ܺϡ�this_arrange_amount_sum�����õ����ڼ��㹤�����رȵ�����
  set rs=Server.CreateObject("ADODB.Recordset")
  sql="select sum(arrange_amount) as arrange_amount_sum from arrange_amount_info where arrange_no='"&arrange_no&"' and arrange_group='"&arrange_group&"'"
  rs.open sql,conn,1,1
  this_arrange_amount_sum=this_arrange_amount_sum+cint(rs("arrange_amount_sum"))
  'response.write "this_arrange_amount_sum:"&this_arrange_amount_sum&"<br>"
  rs.close
  set rs=nothing
  set rs1=Server.CreateObject("ADODB.Recordset")
  sql1="select man_hour from item_info where design_no='"&design_no&"'"
  rs1.open sql1,conn,1,1
  man_hour=cint(rs1("man_hour"))
  'response.write "man_hour:"&man_hour&"<br>"
  'response.write "sql1:"&sql1&"<br>"
  rs1.close
  set rs1=nothing
  set rs2=Server.CreateObject("ADODB.Recordset")
  sql2="select * from worker_info where group_id=(select group_id from group_info where group_name='"&arrange_group&"')"
  rs2.open sql2,conn,1,1
  group_worker_sum=rs2.recordcount
  'response.write "group_worker_sum:"&group_worker_sum&"<br>"
  'response.write "sql2:"&sql2&"<br>"
  rs2.close
  set rs2=nothing
  standard_workload=(this_arrange_amount_sum*man_hour)/(3600*group_worker_sum*work_time*(datediff("d",date_start,date_finish)+1))
  
  'ʵ�ʹ�������
  yesterday_all_hour=0
  set rs3=Server.CreateObject("ADODB.Recordset")
  sql3="SELECT SUM(day_amount) AS yesterday_amount_sum, arrange_no FROM day_produce_info WHERE (day_date = '"&dateadd("d",-1,datevalue(now()))&"') AND (day_group = '"&arrange_group&"') GROUP BY arrange_no"
  'response.write sql3&"<br>"
  rs3.open sql3,conn,1,1
  while not rs3.eof
    set rs4=Server.CreateObject("ADODB.Recordset")
    sql4="select man_hour from item_info where design_no=(select design_no from arrange_info where arrange_no='"&rs3("arrange_no")&"')"
    'response.write sql4&"<br>"
    rs4.open sql4,conn,1,1
    yesterday_all_hour=yesterday_all_hour+cint(rs3("yesterday_amount_sum"))*cint(rs4("man_hour"))
    'response.write rs3("yesterday_amount_sum")&"|"&rs3("arrange_no")&"|"&rs4("man_hour")&"|"
    rs4.close
    set rs4=nothing
    rs3.movenext
  wend
  rs3.close
  set rs3=nothing
  fact_workload=(this_arrange_amount_sum*man_hour)/(datediff("d",date_start,date_finish)+1)/yesterday_all_hour
  
  '����ÿ�չ���ʱ��
  advice_work_time=(this_arrange_amount_sum*man_hour)/(3600*group_worker_sum*(datediff("d",date_start,date_finish)+1))
end if
if return_url<>"" then
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL=<%=return_url%>'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">¼����</td>
  		</tr>
  		<tr>
  			<td align="center"><%=errmsg%></td>
  		</tr>
  	</table>
  </body>
</html>
<%else%>
<html>
	<head>
		<title></title>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body topmargin=0 leftmargin=0>
  	<br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title" colspan=2>�������ط������</td>
  		</tr>
  		<tr>
  			<th width=60%>��׼�������رȣ�</th><td align="center"><%=round(standard_workload*100)%>%</td>
  		</tr>
  		<tr>
  			<th>ʵ�ʹ������رȣ�</th><td align="center"><%=round(fact_workload*100)%>%</td>
  		</tr>
  		<tr>
  			<th>����ÿ�չ���ʱ����</th><td align="center"><%=work_time%>Сʱ</td>
  		</tr>
  		<tr>
  			<th>����ÿ�չ���ʱ����</th><td align="center"><%=round(advice_work_time)%>Сʱ</td>
  		</tr>
  	</table>
  	<br>
    <center>
    <input name="input_order" type="button" onclick="MM_goToURL('self','group_finish.asp?date_start=<%=date_start%>&date_finish=<%=date_finish%>&work_time=<%=work_time%>&arrange_amount=<%=arrange_amount%>&suborder_color=<%=suborder_color%>&suborder_size=<%=suborder_size%>&notify_no=<%=notify_no%>&arrange_group=<%=arrange_group%>&arrange_no=<%=arrange_no%>&design_no=<%=design_no%>');return document.MM_returnValue" value="ȷ ��">
    <input name="input_order" type="button" onclick="MM_goToURL('self','input_arrange.asp?arrange_no=<%=arrange_no%>&arrange_group=<%=arrange_group%>&notify_no=<%=notify_no%>&design_no=<%=design_no%>&date_start=<%=date_start%>&date_finish=<%=date_finish%>&work_time=<%=work_time%>');return document.MM_returnValue" value="�� ��">
    <br><br>
    </center>
  </body>
</html>
<%end if%>