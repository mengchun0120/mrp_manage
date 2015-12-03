<!--#include file="../inc/fun.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
	<%
	faxdate=trim(request("faxdate"))
	if faxdate="" then
	   faxdate=datevalue(now())	
       end if	
	%>
<table width="100%" cellspacing=1>
	<tr>
  	<td class="table_title" colspan=2>输入查询日期</td>
  </tr>
  <form action="showfax.asp" method=post target="mainFrame">
  <tr>
  	<th>输入查询日期：</th>
  	<td align=left><input type="text" name="faxdate" size=10 value="<%=faxdate%>">（格式：YYYY-MM-DD）
  		<input name="affirm_order" type="submit" value="查 询">
      <input name="affirm_order" type="reset" value="重 置">
  	</td> 
  </tr>
</form>
</table>
<table width="100%"> 
<tr>
  <td class="table_title" colspan="4">当前共享的传真文件如下：</td>
</tr>
<tr> 
<td>文件名</td> 
<td>创建时间</td> 
<td>文件大小</td>
<td>操作</td>
</tr> 

<%
  dim ObjFileSys
  dim MyFolder
  dim MyFiles
  dim MyFile

  Set ObjFileSys=Server.CreateObject("Scripting.FileSystemObject")
  ma=server.mappath("/filelink/filefax/")
  Set  MyFolder=ObjFileSys.GetFolder(ma)
  Set  MyFiles=MyFolder.Files
%>    
<% 
filecount=0
For Each  MyFile in MyFiles
    pa=ma&"\"&MyFile.Name
    if datevalue(MyFile.DateCreated)=datevalue(faxdate) then
    	filecount=filecount+1
    s=MyFile.Size/(1024*1024)
    g="http://192.168.0.200/filelink/filefax/"&MyFile.Name
%>
<form action="fax_delete.asp" method="post">
<input type=hidden name=filename value="<%=pa%>">
     <tr>
     <td><a href=<%=g%> target=blank><%=MyFile.Name%></a></td>
     <td><%=MyFile.DateCreated%></td>
     <td><%=round(s,2)%>M</td>
     <td><input type=submit value="删除"></td>
     </tr>
     </form>
<%
end if
Next
%>
</table>
<p align=right>共有<%=filecount%>个文件
<p align=center>
<input name=btnbak type="button" onclick="MM_goToURL('self','fax_shangchuan.asp');return document.MM_returnValue" value="上传新文件"></p> 
</body> 
</HTML>



