<!--#include file="../inc/fun.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<table width="100%"> 
<tr>
  <td class="table_title" colspan="4">��ǰ�����ļ����е��ļ����£�</td>
</tr>
<tr> 
<td>�ļ���</td> 
<td>����ʱ��</td> 
<td>�ļ���С</td>
<td>����</td>
</tr> 

<%
  dim ObjFileSys
  dim MyFolder
  dim MyFiles
  dim MyFile

  Set ObjFileSys=Server.CreateObject("Scripting.FileSystemObject") 
  ma=server.mappath("/filelink/fileshare/")
  Set  MyFolder=ObjFileSys.GetFolder(ma)
  Set  MyFiles=MyFolder.Files
%>    
<% For Each  MyFile in MyFiles
    pa=ma&"\"&MyFile.Name
    s=MyFile.Size/(1024*1024)
    g="http://192.168.0.200/filelink/fileshare/"&cstr(MyFile.Name)
%>
<form action="file_delete.asp" method="post">
<input type=hidden name=filename value="<%=pa%>">
     <tr>
     <td><a href=<%=g%> target=blank><%=MyFile.Name%></a></td>
     <td><%=MyFile.DateCreated%></td>
     <td><%=round(s,2)%>M</td>
     <td><input type=submit value="ɾ��"></td>
     </tr>
     </form>
<%Next%>
</table>
<p align=right>����<%=MyFiles.Count%>���ļ�
<p align=center>
<input name=btnbak type="button" onclick="MM_goToURL('self','file_shangchuan.asp');return document.MM_returnValue" value="�ϴ����ļ�"></p> 
</body> 
</HTML>



