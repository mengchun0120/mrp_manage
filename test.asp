<%=string(5,"asdflkjkertjasadfasdfjltrejkf")%>
<%=strreverse("asdflkjkertjasadfasdfjltrejkf")%>
<%=time()%>
<%
Dim strPath 
strPath = "HKEY_LOCAL_MACHINE\SOFTWARE\mrpii\zf\updatetime" 
Set objShell = CreateObject("WScript.Shell")
if datediff("d",datevalue(now()),objShell.RegRead(strPath))>0 then
  Response.Write "合法！"
else
	Response.Write "不合法！"
end if
%>
<html> 

<head> 
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"> 
<meta name="ProgId" content="FrontPage.Editor.Document"> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"> 
<title>可编辑下拉框</title> 
<style> 
a{color:blue;text-decoration:none} 
a:hover{color:red} 
</style> 
</head> 

<body>

<table style="border:2px outset;background-color:#d2e8FF" width="250" height="100" align="center"> 
  <tr> 
    <td width="100%" align="center" colspan="2"><b>可编辑下拉框</b></td> 
  </tr> 
  <tr> 
    <td width="60%" height="30" align="center"> 
<select name="fason"> 
<option value="可编辑下拉框">可编辑下拉框</option> 
<option value="作者:阿信">阿信</option> 
</select> 
    </td> 
    <td width="40%" height="30" align="left"> 
    <input type=button value=" 取值 " onclick="alert(document.getElementsByName('combox_fason')[0].value)"> 
</td> 
  </tr> 
</table> 


<script language="javascript"> 
/* 
作者：fason(阿信) 
日期：2003-7-1 
版本：v1.0 
备注：只作技术交流，如需转载请注明作者等有关信息，多谢合作 
*/ 
function combox(obj,select){ 
this.obj=obj 
this.name=select; 
this.select=document.getElementsByName(select)[0]; 
/*要转换的下拉框*/ 
} 

/*初始化对象*/ 
combox.prototype.init=function(){ 
var inputbox="<input name='combox_"+this.name+"' onchange='"+this.obj+".find()' " 
inputbox+="style='position:absolute;width:"+(this.select.offsetWidth-16)+";height:"+this.select.offsetHeight+";left:"+getL(this.select)+";top:"+getT(this.select)+"'>" 
document.write(inputbox) 
with(this.select.style){ 
left=getL(this.select) 
top=getT(this.select) 
position="absolute" 
clip="rect(0 "+(this.select.offsetWidth)+" "+this.select.offsetHeight+" "+(this.select.offsetWidth-18)+")" 
/*切割下拉框*/ 
} 
this.select.onchange=new Function(this.obj+".change()") 
this.change() 

} 
/*初始化结束*/ 

////////对象事件定义/////// 
combox.prototype.find=function(){ 
/*当搜索到输入框的值时,下拉框自动定位*/ 
var inputbox=document.getElementsByName("combox_"+this.name)[0] 
with(this.select){ 
for(i=0;i<options.length;i++) 
if(options[i].text.indexOf(inputbox.value)==0){ 
selectedIndex=i 
this.change(); 
break; 
} 
} 
} 

combox.prototype.change=function(){ 
/*定义下拉框的onchange事件*/ 
var inputbox=document.getElementsByName("combox_"+this.name)[0] 
inputbox.value=this.select.options[this.select.selectedIndex].text; 
with(inputbox){select();focus()}; 
} 
////////对象事件结束/////// 

/*公用定位函数(获取控件绝对坐标)*/ 
function getL(e){ 
var l=e.offsetLeft; 
while(e=e.offsetParent)l+=e.offsetLeft; 
return l 
} 
function getT(e){ 
var t=e.offsetTop; 
while(e=e.offsetParent)t+=e.offsetTop; 
return t 
} 
/*结束*/ 
</script> 
<script language="javascript"> 
var a=new combox("a","fason") 
a.init() 
/*作用方法： 
var obj=new combox(var1,var2) 
var1:新生成的combox变量(如:a) 
var2:原下拉框的name 
obj.init():对象初始化 
注意:后台取值时用combox_var2进行取值 
*/ 
</script> 
</body> 

</html> 
