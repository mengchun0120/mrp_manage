<%@ Language=VBScript %>
<%
sub saveBin2File(srmSource,posB,posLen,strPath)
dim srmObj
set srmObj = server.CreateObject("adodb.stream")
srmObj.Type = 1
srmObj.Mode = 3
srmObj.Open 
srmSource.Position = posB-1
srmSource.CopyTo srmObj,posLen
srmObj.Position = 0
srmObj.SaveToFile strPath,2
srmObj.Close
set srmObj = nothing
end sub

function getTextfromBin(srmSource,posBegin,posLen)
dim srmObj, strData
set srmObj = server.CreateObject("adodb.stream")
srmObj.Type = 1
srmObj.Mode = 3
srmObj.Open 
srmSource.position = posBegin-1
srmSource.CopyTo srmObj,posLen
srmObj.Position = 0
srmObj.Type = 2
srmObj.Charset = "gb2312"
strData = srmObj.ReadText 
srmObj.Close 
set srmObj = nothing
getTextfromBin = strData
end function

function getSBfromDB(bytString)
dim bin, i
bin = ""
for  i=1 to len(bytString)
bin = bin & chrb(asc(mid(bytString,i,1)))
next
getSBfromDB = bin
end function

function getDBfromSB(bitString)
dim str, i
str = ""
for i=1 to lenb(bitString)
str = str & chr(ascb(midb(bitString,i,1)))
next
getDBfromSB = str
end function

function getFileNamefromPath(strPath)
getFileNamefromPath = mid(strPath,instrrev(strPath,"\")+1)
end function

function iif(cond,expr1,expr2)
if cond then
iif = expr1
else
iif = expr2
end if
end function
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body topmargin=0 leftmargin=0>
<%
if request.ServerVariables("REQUEST_METHOD") = "POST" then
dim sCome, binData
dim posB, posE, posSB, posSE
dim binCrlf, binSub
dim strTitle, strFileName, strContentType, posFileBegin, posFileLen, aryFileInfo
dim i, j
dim dicData
dim strName,strValue
binCrlf = getSBfromDB(vbcrlf)
binSub = getSBfromDB("--")
set sCome = server.CreateObject("adodb.stream")
sCome.Type = 1
sCome.Mode = 3
sCome.Open 
sCome.Write request.BinaryRead(request.TotalBytes)
sCome.Position = 0
binData = sCome.Read
posB = instrb(binData,binSub)
posB = instrb(posB,binData,bincrlf) + 2
posB = instrb(posB,binData,getSBfromDB("name=""")) + 6
set dicData = server.CreateObject("scripting.dictionary")
do until posB=6
posE = instrb(posB,binData,getSBfromDB(""""))
strName = getTextfromBin(sCome,posB,posE-posB)
posB = posE + 1
posE = instrb(posB,binData,bincrlf)
if instrb(midb(binData,posB,posE-posB),getSBfromDB("filename=""")) > 0 then
posB = instrb(posB,binData,getSBfromDB("filename=""")) + 10
posE = instrb(posB,binData,getSBfromDB(""""))
if posE>posB then 
strFileName = getFileNamefromPath(getTextfromBin(sCome,posB,posE-posB))
posB = instrb(posB,binData,getSBfromDb("Content-Type:")) + 14
posE = instrb(posB,binData,bincrlf)
strContentType = getTextfromBin(sCome,posB,posE-posB)
posB = posE + 4
posE = instrb(posB,binData,binSub)
posFileBegin = posB
posFileLen = posE-posB-1
strValue = strFileName & "," & strContentType & "," & posFileBegin & "," & posFileLen
else
strValue = ""
end if
else
posB = posE + 4
posE = instrb(posB,binData,binCrlf)
strValue = getTextfromBin(sCome,posB,posE-posB)
end if
dicData.Add strName,strValue
posB = posE + 2
posB = instrb(posB,binData,bincrlf) + 2
posB = instrb(posB,binData,getSBfromDB("name=""")) + 6
loop
aryFileInfo = dicData.Item("filImage")
if aryFileInfo <> "" then
aryFileInfo = split(aryFileInfo,",")
strFileName = aryFileInfo(0)
strContentType = aryFileInfo(1)
posFileBegin = aryFileInfo(2)
posFileLen = aryFileInfo(3)
sCome.Position = posFileBegin-1
binData = sCome.Read(posFileLen)
pa=server.mappath("/filelink/fileshare/")
filen=pa&"\"&strFileName
saveBin2File sCome,posFileBegin,posFileLen,filen
time_out=0
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL="showfile.asp"'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">上传结果</td>
  		</tr>
  		<tr>
  			<td align="center">文件上传成功！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
else
	time_out=2
%>
<html>
	<head>
		<title></title>
    <META HTTP-EQUIV=REFRESH CONTENT='<%=time_out%>; URL="showfile.asp"'>
    <link href="../css/global.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  	<br><br><br><br><br><br><br><br><br><br><br>
  	<table border=0 align="center" width="400" cellspacing=1>
  		<tr>
  			<td class="table_title">上传结果</td>
  		</tr>
  		<tr>
  			<td align="center">文件没有上传成功！</td>
  		</tr>
  	</table>
  </body>
</html>
<%
end if
sCome.Close 
set sCome = nothing
else
%>
　　<form action="<%=Request.ServerVariables("script_name")%>" method="post" target="_self" enctype="multipart/form-data">　　
　　　<center>文件：<INPUT id="filImage" type="file" name="filImage" size="40"></p>
　　　<INPUT id="upload" type="submit" value="确定上传" name="btnUpload"></center>
　　</form>
<%
end if
%>
　</body>
</HTML>