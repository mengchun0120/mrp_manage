<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
td {
	font-family: "宋体";
	font-size: 9pt;
	color: #ffffff;
}
a:link {color: #ffffff; text-decoration: none} /* 未访问的链接 */
a:visited {color: #ffffff; text-decoration: none} /* 已访问的链接 */
a:hover {color: #FFA34F; text-decoration: underline} /* 鼠标在链接上 */
a:active {color: #FFA34F; text-decoration: underline} /* 激活链接 */
</style>
<title></title>
</head>
<script language="JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v3.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver= nbArr=new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : args[i+1];
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    
  } else if (event == "down") {
    if ((nbArr = document[grpName]) != null)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = args[i+1];
      nbArr[nbArr.length] = img;
  } }
}
//-->
</script>
<body topmargin=0 leftmargin=0 background="img/menubg.gif">
<table width="1000" height=75 border="0" cellspacing="0" cellpadding="0">
  <tr height=50>
    <td width=150></td>
    <td width=80><a href="menu_order.asp" target="leftFrame" onClick="MM_nbGroup('down','group1','orderform','img/menu1b.gif',1)" onMouseOut="MM_nbGroup('out')"><img src="img/menu1a.gif" border="0" name="orderform"></a></td>
    <td width=80><a href="menu_person.asp" target="leftFrame" onClick="MM_nbGroup('down','group1','orderform1','img/menu2b.gif',1)" onMouseOut="MM_nbGroup('out')"><img src="img/menu2a.gif" border="0" name="orderform1"></a></td>
    <td width=80><a href="menu.asp" target="leftFrame" onClick="MM_nbGroup('down','group1','orderform2','img/menu1b.gif',1)" onMouseOut="MM_nbGroup('out')"><img src="img/menu1a.gif" border="0" name="orderform2"></a></td>
    <td width=610></td>
  </tr>
  <tr bgcolor="#5AA8DA" height=25>
    <td></td>
    <td colspan=5 align="right">当前登录人：<%=session("username")%> | <a href="operator_manage/edit_pwd.asp" target="mainFrame">修改密码</a> | <a href="logout.asp" target="mainFrame">安全退出</a> | 版权所有 CopyRight 2005</td>
  </tr>
</table>
</body>
</html>