<%
'Dim strPath 
'strPath = "HKEY_LOCAL_MACHINE\SOFTWARE\mrpii\zf\updatetime" 
'Set objShell = CreateObject("WScript.Shell")
'if datediff("d",datevalue(now()),objShell.RegRead(strPath))<0 then
Db = "inc/test.asp"
ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(db)
Set conn = Server.CreateObject("ADODB.Connection")
conn.open ConnStr
set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from test"
rs.open sql,conn,1,3
if datediff("d",datevalue(now()),rs("my_date"))<0 then
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html dir=ltr>

<head>
<style> a:link			{font:9pt/11pt ����; color:FF0000} a:visited		{font:9pt/11pt ����; color:#4e4e4e}
</style>

<META NAME="ROBOTS" CONTENT="NOINDEX">

<title>�޷��ҵ���ҳ</title>

<META HTTP-EQUIV="Content-Type" Content="text-html; charset=gb2312">
<META NAME="MS.LOCALE" CONTENT="ZH-CN">
</head>

<script>
function Homepage(){
<!--
// in real bits, urls get returned to our script like this:
// res://shdocvw.dll/http_404.htm#http://www.DocURL.com/bar.htm

	//For testing use DocURL = "res://shdocvw.dll/http_404.htm#https://www.microsoft.com/bar.htm"
	DocURL = document.URL;

	//this is where the http or https will be, as found by searching for :// but skipping the res://
	protocolIndex=DocURL.indexOf("://",4);

	//this finds the ending slash for the domain server
	serverIndex=DocURL.indexOf("/",protocolIndex + 3);

		//for the href, we need a valid URL to the domain. We search for the # symbol to find the begining
	//of the true URL, and add 1 to skip it - this is the BeginURL value. We use serverIndex as the end marker.
	//urlresult=DocURL.substring(protocolIndex - 4,serverIndex);
	BeginURL=DocURL.indexOf("#",1) + 1;

	urlresult=DocURL.substring(BeginURL,serverIndex);

	//for display, we need to skip after http://, and go to the next slash
	displayresult=DocURL.substring(protocolIndex + 3 ,serverIndex);

	InsertElementAnchor(urlresult, displayresult);
}

function HtmlEncode(text)
{
    return text.replace(/&/g, '&amp').replace(/'/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

function TagAttrib(name, value)
{
    return ' '+name+'="'+HtmlEncode(value)+'"';
}

function PrintTag(tagName, needCloseTag, attrib, inner){
    document.write( '<' + tagName + attrib + '>' + HtmlEncode(inner) );
    if (needCloseTag) document.write( '</' + tagName +'>' );
}

function URI(href)
{
    IEVer = window.navigator.appVersion;
    IEVer = IEVer.substr( IEVer.indexOf('MSIE') + 5, 3 );

    return (IEVer.charAt(1)=='.' && IEVer >= '5.5') ?
        encodeURI(href) :
        escape(href).replace(/%3A/g, ':').replace(/%3B/g, ';');
}

function InsertElementAnchor(href, text)
{
    PrintTag('A', true, TagAttrib('HREF', URI(href)), text);
}

//-->
</script>

<body bgcolor="FFFFFF">

<table width="410" cellpadding="3" cellspacing="5">

  <tr>
    <td align="left" valign="middle" width="360">
	<h1 style="COLOR:000000; FONT: 12pt/15pt ����"><!--Problem-->�޷��ҵ���ҳ</h1>
    </td>
  </tr>

  <tr>
<td width="400" colspan="2"> <font style="COLOR:000000; FONT: 9pt/11pt ����">��������������ҳ�����Ѿ�ɾ������������ʱ�����á�</font></td>
  </tr>

  <tr>
    <td width="400" colspan="2"> <font style="COLOR:000000; FONT: 9pt/11pt ����">

	<hr color="#C0C0C0" noshade>

<p>�볢�����в�����</p>

	<ul>
<li>������ڡ���ַ�����м�������ҳ��ַ��������ƴд�Ƿ���ȷ��<br>
      </li>

<li>�� <script>
	  <!--
	  if (!((window.navigator.userAgent.indexOf("MSIE") > 0) && (window.navigator.appVersion.charAt(0) == "2")))
	  {
	  	Homepage();
	  }
	  //-->
	   </script> ��ҳ��Ѱ��ָ��������Ϣ�����ӡ�</li>

<li>����<a href="javascript:history.back(1)">����</a>��ť�����������ӡ�</li>
    </ul>

<h2 style="font:9pt/11pt ����; color:000000">HTTP 404 - �޷��ҵ��ļ�<br> Internet ��Ϣ����<BR></h2>

	<hr color="#C0C0C0" noshade>

	<p>������Ϣ��֧�ָ��ˣ�</p>

<ul>
<li>��ϸ��Ϣ��<br><a href="http://www.microsoft.com/ContentRedirect.asp?prd=iis&sbp=&pver=5.0&pid=&ID=404&cat=web&os=&over=&hrd=&Opt1=&Opt2=&Opt3=" target="_blank">Microsoft ֧��</a>
</li>
</ul>

    </font></td>
  </tr>

</table>
</body>
</html>
<%
response.end
end if
%>