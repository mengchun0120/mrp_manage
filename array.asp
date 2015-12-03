<%
arr=request("arr")
%>
<form method=post action="array.asp">
<%
for i=1 to 10
%>
<input type=text name=arr>
<%
next
%>
<input name="affirm_order" type="submit" value="È·ÈÏÊäÈë">
</form>
<%'=arr%>
<br><%
a=split(arr,",")
response.write ubound(a)
for i=0 to ubound(a)
  response.write "+"&a(i)&"|"
next
%>