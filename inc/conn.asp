<%
'sql数据库连接参数：数据库名、用户密码、用户名、连接名
Dim SqlDatabaseName,SqlPassword,SqlUsername,SqlLocalName
SqlDatabaseName = "zf"
SqlPassword = "sql"
SqlUsername = "sa"
SqlLocalName = "127.0.0.1"
ConnStr = "Provider = Sqloledb; User ID = " & SqlUsername & "; Password = " & SqlPassword & "; Initial Catalog = " & SqlDatabaseName & "; Data Source = " & SqlLocalName & ";"
On Error Resume Next
Set conn = Server.CreateObject("ADODB.Connection")
conn.open ConnStr
If Err Then
	err.Clear
	Set Conn = Nothing
	Response.Write "数据库连接出错，请检查连接字串。"
	Response.End
End If
%>