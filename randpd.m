%% 子函数4：在20*20km的区域内随机生成乘客与司机数据
% 输入：num_pas：整数，生成的乘客数量
%       num_driv：整数，生成的司机数量
%       min_dis：浮点数，乘客乘车距离最小阈值
% 输出：pas：(num_pas*2)*2矩阵，每两行为一组数据，分别代表各乘客的起点与终点
%       driv：num_driv*2矩阵，司机位置
function [pas,driv]=randpd(num_pas,num_driv,min_dis)
pas=[]; 
driv=rand(num_driv,2)*20;
while size(pas,1)~=num_pas*2
    pas_t=rand(2,2)*20;
    if dis(pas_t(1,:),pas_t(2,:))>min_dis
        pas=[pas;pas_t];
    end
end
end