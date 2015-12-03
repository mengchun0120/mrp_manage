<%
work_day=30
y=50
response.write "<hr align=left width="&y&">"&y
for x=2 to work_day
  y=y*(1+2/x/x)
  y=round(Y)
  response.write "<hr align=left width="&y&">"&y
next
%>