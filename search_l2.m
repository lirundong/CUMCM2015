%% 函数2：搜索第二层
% flag_in=1:已搜索点在上边
% flag_in=2:已搜索点在下边
% flag_in=3:已搜索点在左边
% flag_in=4:已搜索点在右边
function web_out=search_l2(web_in,x,i,j,flag_in)
[a,b]=size(web_in);
if flag_in==1 % 不搜索上边点
    if i+1>a && j+1>b % 超过下边和右边
        web_in(i,j-1)=web_in(i,j-1)-x;
    elseif i+1>a && j-1<1 % 超过下边和左边
        web_in(i,j+1)=web_in(i,j+1)-x;
    elseif i+1>a % 超过下边
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    elseif j+1>b % 超过右边
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/2;
    elseif j-1<1 % 超过左边
        web_in(i,j+1)=web_in(i,j+1)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/2;
    else
        web_in(i,j-1)=web_in(i,j-1)-x/3;
        web_in(i,j+1)=web_in(i,j+1)-x/3;
        web_in(i+1,j)=web_in(i+1,j)-x/3;
    end
elseif flag_in==2 % 不搜索下边点
    if i-1<1 && j+1>b % 超过上边和右边
        web_in(i,j-1)=web_in(i,j-1)-x;
    elseif i-1<1 && j-1<1 % 超过上边和左边
        web_in(i,j+1)=web_in(i,j+1)-x;
    elseif i-1<1 % 超过上边
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    elseif j+1>b % 超过右边
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    elseif j-1<1 % 超过左边
        web_in(i,j+1)=web_in(i,j+1)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    else
        web_in(i,j-1)=web_in(i,j-1)-x/3;
        web_in(i,j+1)=web_in(i,j+1)-x/3;
        web_in(i-1,j)=web_in(i-1,j)-x/3;
    end
elseif flag_in==3 % 不搜索左边点
    if i-1<1 && j+1>b % 超过上边和右边
        web_in(i+1,j)=web_in(i+1,j)-x;
    elseif i+1>a && j+1>b % 超过下边和右边
        web_in(i-1,j)=web_in(i-1,j)-x;
    elseif j+1>b % 超过右边
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    elseif i+1>a % 超过下边
        web_in(i-1,j)=web_in(i-1,j)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    elseif i-1<1 % 超过上边
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    else
        web_in(i+1,j)=web_in(i+1,j)-x/3;
        web_in(i-1,j)=web_in(i-1,j)-x/3;
        web_in(i,j+1)=web_in(i,j+1)-x/3;
    end
elseif flag_in==4 % 不搜索右边点
    if i-1<1 && j-1<1 % 超过上边和左边
        web_in(i+1,j)=web_in(i+1,j)-x;
    elseif i+1>a && j-1<1 % 超过下边和左边
        web_in(i-1,j)=web_in(i-1,j)-x;
    elseif j-1<1 % 超过左边
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    elseif i+1>a % 超过下边
        web_in(i-1,j)=web_in(i-1,j)-x/2;
        web_in(i,j-1)=web_in(i,j-1)-x/2;
    elseif i-1<1 % 超过上边
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i,j-1)=web_in(i,j-1)-x/2;
    else
        web_in(i+1,j)=web_in(i+1,j)-x/3;
        web_in(i-1,j)=web_in(i-1,j)-x/3;
        web_in(i,j-1)=web_in(i,j-1)-x/3;
    end
end
web_out=web_in;
end