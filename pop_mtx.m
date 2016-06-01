%% 画出人口密度网格
clear; clc;
%% 读取相关数据
% 读取成都市地图数据
map_Chengdu=shaperead('D:\File\CUMCM2015\B\地图\成都市shp地图\县界_region.shp');
% 读取各地区坐标与人口
% 各列依次为：纬度	经度	总人口
[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\地图\test\成都市批量坐标_geo_ok.xlsx','OK','B2:D413');
data_pop_loc = reshape([raw{:}],size(raw));
clearvars raw;
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
% 绘出三维图像
[xx,yy]=meshgrid(x,y);
surf(xx,yy,pop_grid);
shading interp;