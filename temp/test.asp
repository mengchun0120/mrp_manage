<table width="100%" cellspacing=1>
	<tr   onmouseout="this.style.background='#FFFF00'"  onmouseover="this.style.background='#BDDFFF'">
  	<td colspan="9">���ͷ��</td>
  </tr>
  <tr  onmouseout="this.style.background='#FFFF00'"  onmouseover="this.style.background='#BDDFFF'">
    <th width="120">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<br>������<br>������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th>����������</th>
    <th>����������</th>
    <th>����������</th>
    <th>����������</th>
    <th>����������</th>
    <th>����������</th>
    <th>����������</th>
    <th>����������</th>
  </tr>
  <tr  onmouseout="this.style.background='#FFFF00'"  onmouseover="this.style.background='#BDDFFF'">
    <th>����������</th>
    <td bgcolor=red>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr  onmouseout="this.style.background='#FFFFFF'"  onmouseover="this.style.background='#BDDFFF'">
    <th>����������</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>����������</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>����������</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>a</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>a</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>a</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>a</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
  <tr>
    <th>a</th>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
    <td>d</td>
  </tr>
</table>
<%
a=request("a")
b=request("b")
response.write a&b
response.write cbyte("255.17")
response.write ccur("4454534255.17452325")
%>
<br><%
dim tmp(5)
tmp(0)="a"
tmp(1)="s"
tmp(2)="d"
tmp(3)="f"
tmp(4)="g"
all=join(tmp,"||")
response.write all
%>
<br><%
a=split("1;2;3;4;5;6;7;8;",";")
response.write a(0)&a(1)&a(2)&a(3)&a(4)
%>
<br><%=string(5,"f")%>
<br><%=weekdayname(weekday(2005-11-16),,2)%>
<br><%%>
<br><%%>
<br><%%>
<br><%%>
<br><%%>
<br><%%>
<br><%%>
<br><%%>