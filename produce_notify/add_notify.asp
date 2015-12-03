y=right(year(now()),2)
set s=conn.execute("select distinct notify_id from produce_notify")
num=1
while not s.eof
   if (instr(s("notify_id"),y)<>0) then
      num=num+1
   end if
   s.movenext
wend
pn1="BT-"&y&"-B-"&num
response.write no_id&"<br>"
for m=0 to ubound(a)
   response.write a(m)&"   "&b(m)&"<br>"
   if trim(b(m))<>"" then
      response.write "insert into produce_notify(notify_id,suborder_no,number) values ('"&no1&"',"&a(m)&","&b(m)&")"
      set nin=conn.execute("insert into produce_notify(notify_id,suborder_no,number)values('"&pn1&"','"&a(m)&"','"&b(m)&"')")
   end if
next
