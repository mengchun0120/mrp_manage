<%=string(5,"asdflkjkertjasadfasdfjltrejkf")%>
<%=strreverse("asdflkjkertjasadfasdfjltrejkf")%>
<%=time()%>
<%
Dim strPath 
strPath = "HKEY_LOCAL_MACHINE\SOFTWARE\mrpii\zf\updatetime" 
Set objShell = CreateObject("WScript.Shell")
if datediff("d",datevalue(now()),objShell.RegRead(strPath))>0 then
  Response.Write "�Ϸ���"
else
	Response.Write "���Ϸ���"
end if
%>
<html> 

<head> 
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"> 
<meta name="ProgId" content="FrontPage.Editor.Document"> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"> 
<title>�ɱ༭������</title> 
<style> 
a{color:blue;text-decoration:none} 
a:hover{color:red} 
</style> 
</head> 

<body>

<table style="border:2px outset;background-color:#d2e8FF" width="250" height="100" align="center"> 
  <tr> 
    <td width="100%" align="center" colspan="2"><b>�ɱ༭������</b></td> 
  </tr> 
  <tr> 
    <td width="60%" height="30" align="center"> 
<select name="fason"> 
<option value="�ɱ༭������">�ɱ༭������</option> 
<option value="����:����">����</option> 
</select> 
    </td> 
    <td width="40%" height="30" align="left"> 
    <input type=button value=" ȡֵ " onclick="alert(document.getElementsByName('combox_fason')[0].value)"> 
</td> 
  </tr> 
</table> 


<script language="javascript"> 
/* 
���ߣ�fason(����) 
���ڣ�2003-7-1 
�汾��v1.0 
��ע��ֻ����������������ת����ע�����ߵ��й���Ϣ����л���� 
*/ 
function combox(obj,select){ 
this.obj=obj 
this.name=select; 
this.select=document.getElementsByName(select)[0]; 
/*Ҫת����������*/ 
} 

/*��ʼ������*/ 
combox.prototype.init=function(){ 
var inputbox="<input name='combox_"+this.name+"' onchange='"+this.obj+".find()' " 
inputbox+="style='position:absolute;width:"+(this.select.offsetWidth-16)+";height:"+this.select.offsetHeight+";left:"+getL(this.select)+";top:"+getT(this.select)+"'>" 
document.write(inputbox) 
with(this.select.style){ 
left=getL(this.select) 
top=getT(this.select) 
position="absolute" 
clip="rect(0 "+(this.select.offsetWidth)+" "+this.select.offsetHeight+" "+(this.select.offsetWidth-18)+")" 
/*�и�������*/ 
} 
this.select.onchange=new Function(this.obj+".change()") 
this.change() 

} 
/*��ʼ������*/ 

////////�����¼�����/////// 
combox.prototype.find=function(){ 
/*��������������ֵʱ,�������Զ���λ*/ 
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
/*�����������onchange�¼�*/ 
var inputbox=document.getElementsByName("combox_"+this.name)[0] 
inputbox.value=this.select.options[this.select.selectedIndex].text; 
with(inputbox){select();focus()}; 
} 
////////�����¼�����/////// 

/*���ö�λ����(��ȡ�ؼ���������)*/ 
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
/*����*/ 
</script> 
<script language="javascript"> 
var a=new combox("a","fason") 
a.init() 
/*���÷����� 
var obj=new combox(var1,var2) 
var1:�����ɵ�combox����(��:a) 
var2:ԭ�������name 
obj.init():�����ʼ�� 
ע��:��̨ȡֵʱ��combox_var2����ȡֵ 
*/ 
</script> 
</body> 

</html> 
