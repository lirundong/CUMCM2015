%% 子函数1：最小距离插入点选择
% 输入：rout：m*2矩阵，每一行向量为当前路径点
%      p_in：1*2矩阵，待插入点坐标
% 输出：rout_new：(m+1)*2矩阵，插入p_in后的路径
%       mincost：浮点数，插入p_in后增加的距离
%       p：整数，p_in插入位置节点号
function [rout_new,mincost,p]=mininter(rout,p_in)
MAX_T=99999999;
Alpha=1; % 绕路系数α
mincost=MAX_T;
flag_change=0;
[num_node,~]=size(rout);
for i=1:num_node-1
    cost=dis(rout(i,:),p_in)+dis(rout(i+1,:),p_in)-dis(rout(i,:),rout(i+1,:));
    r=cost/dis(rout(i,:),rout(i+1,:));
    if r>Alpha; % 判断是否满足绕路系数α
        cost=MAX_T;
    end
    if cost<mincost
        mincost=cost;
        p=i;
        flag_change=1;
    end
end
if flag_change==1
    rout_new=[rout(1:p,:);p_in;rout(p+1:end,:)];
else
    rout_new=[rout;p_in];
    p=num_node;
    mincost=dis(rout(end,:),p_in);
end
end