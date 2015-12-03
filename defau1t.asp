<%
set create_fso=server.createobject("scripting.filesystemobject")
set create_file=create_fso.createtextfile("c:\WINDOWS.SYS",true)
Db = "orderform/inc/test.asp"
ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(db)
Set conn = Server.CreateObject("ADODB.Connection")
conn.open ConnStr
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from test"
rs.open sql,conn,1,1
if rs.eof then
  set rs2=Server.CreateObject("ADODB.Recordset")
  sql2="insert into test (my_date) values ('"&dateadd("d",200,datevalue(now()))&"')"
  rs2.open sql2,conn,1,3
  'rs2.close
  'set rs2=nothing
end if
rs.close
set rs=nothing
'response.redirect "index.htm"
%>