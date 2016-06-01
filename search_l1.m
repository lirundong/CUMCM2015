%% ËÑË÷Á½²ãµÄº¯Êı
%% º¯Êı1£ºËÑË÷µÚÒ»²ã
function web_out=search_l1(web_in,x,i,j)
[a,b]=size(web_in);
if web_in(i,j)>=x
    web_in(i,j)=web_in(i,j)-x;
elseif i==1 && j==1 % ×óÉÏ½Ç
    if sum([web_in(i,j),web_in(i+1,j),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/4;
        web_in(i,j+1)=web_in(i,j+1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i+1,j,1);
        web_in=search_l2(web_in,x/4,i,j+1,3);
    end
elseif i==a && j==1 % ×óÏÂ½Ç
    if sum([web_in(i,j),web_in(i-1,j),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/4;
        web_in(i,j+1)=web_in(i,j+1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i-1,j,2);
        web_in=search_l2(web_in,x/4,i,j+1,3);
    end
elseif i==1 && j==b % ÓÒÉÏ½Ç
    if sum([web_in(i,j),web_in(i+1,j),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/4;
        web_in(i,j-1)=web_in(i,j-1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i+1,j,1);
        web_in=search_l2(web_in,x/4,i,j-1,4);
    end
elseif i==a && j==b % ÓÒÏÂ½Ç
    if sum([web_in(i,j),web_in(i-1,j),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/4;
        web_in(i,j-1)=web_in(i,j-1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i-1,j,2);
        web_in=search_l2(web_in,x/4,i,j-1,4);
    end
elseif i==1 % ÉÏ±ß
    if sum([web_in(i,j),web_in(i+1,j),web_in(i,j-1),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/6;
        web_in(i,j-1)=web_in(i,j-1)-x/6;
        web_in(i,j+1)=web_in(i,j+1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i+1,j,1);
        web_in=search_l2(web_in,x/6,i,j-1,4);
        web_in=search_l2(web_in,x/6,i,j+1,3);
    end
elseif i==a % ÏÂ±ß
    if sum([web_in(i,j),web_in(i-1,j),web_in(i,j-1),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/6;
        web_in(i,j-1)=web_in(i,j-1)-x/6;
        web_in(i,j+1)=web_in(i,j+1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i-1,j,2);
        web_in=search_l2(web_in,x/6,i,j-1,4);
        web_in=search_l2(web_in,x/6,i,j+1,3);
    end
elseif j==1 % ×ó±ß
    if sum([web_in(i,j),web_in(i+1,j),web_in(i-1,j),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/6;
        web_in(i-1,j)=web_in(i-1,j)-x/6;
        web_in(i,j+1)=web_in(i,j+1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i+1,j,1);
        web_in=search_l2(web_in,x/6,i-1,j,2);
        web_in=search_l2(web_in,x/6,i,j+1,3);
    end
elseif j==b % ÓÒ±ß
    if sum([web_in(i,j),web_in(i+1,j),web_in(i-1,j),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/6;
        web_in(i-1,j)=web_in(i-1,j)-x/6;
        web_in(i,j-1)=web_in(i,j-1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i+1,j,1);
        web_in=search_l2(web_in,x/6,i-1,j,2);
        web_in=search_l2(web_in,x/6,i,j-1,4);
    end
else % ÖĞ¼ä
    if sum([web_in(i,j),web_in(i+1,j),web_in(i-1,j),web_in(i,j+1),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/8;
        web_in(i-1,j)=web_in(i-1,j)-x/8;
        web_in(i,j+1)=web_in(i,j+1)-x/8;
        web_in(i,j+1)=web_in(i,j+1)-x/8;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/8,i+1,j,1);
        web_in=search_l2(web_in,x/8,i-1,j,2);
        web_in=search_l2(web_in,x/8,i,j+1,3);
        web_in=search_l2(web_in,x/8,i,j-1,4);
    end
end
web_out=web_in;
end