<%
'转换格式显示函数
function trans_code(str)
   if isNULL(str) then 
       trans_code=""
       exit function
    end if
    l=len(str)
    result=""
	for i = 1 to l
	    select case mid(str,i,1)
	           case "<"
	                result=result+"&lt;"
	           case ">"
	                result=result+"&gt;"
              case chr(13)
	                result=result+"<br>"
	           case chr(34)
	                result=result+"&quot;"
	           case "&"
	                result=result+"&amp;"
              case chr(32)	           
	                if i+1<=l and i-1>0 then
	                   if mid(str,i+1,1)=chr(32) or mid(str,i+1,1)=chr(9) or mid(str,i-1,1)=chr(32) or mid(str,i-1,1)=chr(9)  then	                      
	                      result=result+"&nbsp;"
	                   else
	                      result=result+" "
	                   end if
	                else
	                   result=result+"&nbsp;"	                    
	                end if
	           case chr(9)
	                result=result+"    "
	           case else
	                result=result+mid(str,i,1)
         end select
       next 
       trans_code=result
end function
%>