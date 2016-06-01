%% 子函数3：计算乘客i拼搭出租车j的完成时间和路径
% 输入：rout：m*2矩阵，每一行向量为当前路径点
%      p_in：2*2矩阵，每一行待插入点坐标（起点、终点）
% 输出：y：拼车完成时间
function [y_out,rout_new]=minshare(rout,p_in)
v=23; Beta=0.2; % 绕路系数β
MAX_cost=99999999;
num_node=size(rout,1);
y=0;
for i=1:num_node-1
    y=y+dis(rout(i,:),rout(i+1,:));
end
[rout_new,~,~]=mininter(rout,p_in(1,:));
num_node_new=size(rout_new,1);
y_new=0;
for i=1:num_node_new-1
    y_new=y_new+dis(rout_new(i,:),rout_new(i+1,:));
end
if (y_new-y)/y>Beta
    y_new=MAX_cost;
elseif y_new-y<0
    error('插入节点时出现问题！');
end
y_out=y_new/v;
end