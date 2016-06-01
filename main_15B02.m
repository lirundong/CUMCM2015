%% 考虑搜索两层时供求网格匹配度
clear;
%% 读取相关数据
% 读取各地区坐标与人口
% 各列依次为：纬度	经度	总人口
[~, ~, raw] = ...
    xlsread('D:\File\CUMCM2015\B\地图\test\成都市批量坐标_geo_ok.xls',...
    'OK','B2:D413');
data_pop_loc = reshape([raw{:}],size(raw));
clearvars raw;
% 读取出租车需求与分布数据
% 每小时300个数据点
% 数据时间：15/09/05
% 各列依次为经度、纬度、车数
[~, ~, raw] = ...
    xlsread('D:\File\CUMCM2015\B\数据文件\150905_分布与需求.xls',...
    '出租车需求','A2:C1626');
data_dem = reshape([raw{:}],size(raw));
clearvars raw;

[~, ~, raw] = ...
    xlsread('D:\File\CUMCM2015\B\数据文件\150905_分布与需求.xls',...
    '出租车分布','A2:C7225');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); 
raw(R) = {NaN};
data_dist_t = reshape([raw{:}],size(raw));
clearvars raw R;
% 读取企业数据：经度、纬度
[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\数据文件\120个企业.xls',...
    'sheet1','B1:C109');
data_co = reshape([raw{:}],size(raw));
clearvars raw;
%% 处理车辆分布数据
% 处理实际车数与加入在线打车联盟车数的关系
T_dist=300;
for i=1:24
    data_dist(:,:,i)=[data_dist_t((i-1)*T_dist+1:i*T_dist,[1,2]),...
        data_dist_t((i-1)*T_dist+1:i*T_dist,3)*2];
end
%% 设定常数
X_MIN=min(data_pop_loc(:,2));
X_MAX=max(data_pop_loc(:,2));
Y_MIN=min(data_pop_loc(:,1));
Y_MAX=max(data_pop_loc(:,1));
%% 创建人口密度网格
x=linspace(X_MIN,X_MAX,100);
y=linspace(Y_MIN,Y_MAX,100);
pop_grid=zeros(100,100);
for i=1:size(data_pop_loc,1)
    index_x=find(x>data_pop_loc(i,2));
    if isempty(index_x)
        index_x=100;
    elseif index_x(1)~=1
        index_x(1)=index_x(1)-1;
    end
    index_y=find(y>data_pop_loc(i,1));
    if isempty(index_y)
        index_y=100;
    elseif index_y(1)~=1
        index_y(1)=index_y(1)-1;
    end
    pop_grid(index_x(1),index_y(1))=data_pop_loc(i,3);
end
%% 创建企业人口密度网络
co_grid=zeros(100,100);
for i=1:size(data_co,1)
    index_x=find(x>data_co(i,1));
    if isempty(index_x)
        index_x=100;
    elseif index_x(1)~=1
        index_x(1)=index_x(1)-1;
    end
    index_y=find(y>data_co(i,2));
    if isempty(index_y)
        index_y=100;
    elseif index_y(1)~=1
        index_y(1)=index_y(1)-1;
    end
    co_grid(index_x(1),index_y(1))=10000+50000*rand(1);
end
%% 创建7点、9点时出租车分布网格
% 各列依次为经度、纬度、车数
car7_grid=zeros(100,100);
car9_grid=zeros(100,100);
for i=1:size(data_dist(:,:,7),1)
    index7_x=find(x>data_dist(i,1,7));
    if isempty(index7_x)
        index7_x=100;
    elseif index7_x(1)~=1
        index7_x(1)=index7_x(1)-1;
    end
    index7_y=find(y>data_dist(i,2,7));
    if isempty(index7_y)
        index7_y=100;
    elseif index7_y(1)~=1
        index7_y(1)=index7_y(1)-1;
    end
    car7_grid(index7_x(1),index7_y(1))=car7_grid(index7_x(1),...
        index7_y(1))+data_dist(i,3,7);  
    index9_x=find(x>data_dist(i,1,9));
    if isempty(index9_x)
        index9_x=100;
    elseif index9_x(1)~=1
        index9_x(1)=index9_x(1)-1;
    end
    index9_y=find(y>data_dist(i,2,9));
    if isempty(index9_y)
        index9_y=100;
    elseif index9_y(1)~=1
        index9_y(1)=index9_y(1)-1;
    end
    car9_grid(index9_x(1),index9_y(1))=car9_grid(index9_x(1),...
        index9_y(1))+data_dist(i,3,9);
end
%% 计算实际需求
% 初始状态需求
pop_grid_std2=pop_grid*2.6*0.062*6.2/((1-0.328)*16*23*2);
pop_std2_sum=sum(sum(pop_grid_std2));
% 上班后需求量
co_grid_std2=pop_std2_sum*co_grid/sum(sum(co_grid));
%% 考虑两层叫车情况
% 供：car7_grid   求：pop_grid_std2
% 早晨7点
% 初始状态
fprintf(sprintf('早晨7点出租车初始空闲运量：%f；\n',...
    sum(sum(abs(car7_grid)))));
for i=1:100 % 行
    for j=1:100 % 列
        car7_grid=search_l1(car7_grid,pop_grid_std2(i,j),i,j);
    end
end
fprintf(sprintf('早晨7点打不到车的人数：%f；\n（越小越好）\n',...
    sum(sum(abs(car7_grid.*car7_grid<=0)))));
fprintf(sprintf('早晨7点空闲的出租车运量：%f；\n（越小越好）\n',...
    sum(sum(abs(car7_grid.*car7_grid>=1)))));
% 早晨9点
% 初始状态
fprintf(sprintf('早晨9点出租车初始空闲运量：%f；\n',...
    sum(sum(abs(car9_grid)))));
for i=1:100 % 行
    for j=1:100 % 列
        car9_grid=search_l1(car9_grid,co_grid_std2(i,j),i,j);
    end
end
fprintf(sprintf('早晨9点打不到车的人数：%f；\n（越小越好）\n',...
    sum(sum(abs(car9_grid.*car9_grid<=0)))));
fprintf(sprintf('早晨9点空闲的出租车运量：%f；\n（越小越好）\n',...
    sum(sum(abs(car9_grid.*car9_grid>=1)))));