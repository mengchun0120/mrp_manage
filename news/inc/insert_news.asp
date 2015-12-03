<%
'插入新闻函数
sub insert_news(news_content,is_show)
  set rs_news=Server.CreateObject("ADODB.Recordset")
  sql_news="insert into news_info (news_who,news_depart,news_content,is_show) values ('"&session("username")&"','"&session("userdepart")&"','"&news_content&"','"&is_show&"')"
  rs_news.open sql_news,conn,1,3
  rs_news.close
  set rs_news=nothing
end sub
%>