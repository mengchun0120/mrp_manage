<%
'sql���ݿ����Ӳ��������ݿ������û����롢�û�����������
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
	Response.Write "���ݿ����ӳ������������ִ���"
	Response.End
End If
%>