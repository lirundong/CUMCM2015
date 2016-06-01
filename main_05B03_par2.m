%% 建立动态拼车模型并模拟
%% 主程序
clear;
v=23; % 行驶速度
max_seats=4; % 每辆车最大载客数
num_pas=30;
num_driv=5;
min_dis=1.5;
[pas,driv]=randpd(num_pas,num_driv,min_dis);
pas_wait=inf*ones(num_pas,2); % 乘客等待时间——路上和车上
% 为每辆车分配初始乘客
% 构造num_driv*4的cell矩阵cars，各列分别为：路径、载客编号、总行驶时间、是否满载
cars=cell(num_driv,4);
dis_car_pas=zeros(num_driv,num_pas);
flag_pas=ones(1,num_pas); % 若乘客已上车，则该flag=0
flag_cars=zeros(1,num_driv); % 车辆满载标记
for I=1:num_driv % 每一辆车
    cars{I,1}=driv(I,:);
    cars{I,4}=0; % 车辆满载标记
    for J=1:num_pas
        if flag_pas(J)==1
            dis_car_pas(I,J)=dis(pas(2*J-1,:),driv(I,:));
        else
            dis_car_pas(I,J)=9999999999;
        end
    end
    [dis_min,idx]=min(dis_car_pas(I,:));
    pas_wait(idx,1)=dis_min/v;
    cars{I,3}=dis_min/v;
    cars{I,2}=[cars{I,2},idx];
    cars{I,1}=[cars{I,1};pas(2*idx-1,:);pas(2*idx,:)];
    flag_pas(idx)=0;
end
% 计算剩余乘客拼车时间
pas_remain=[1:num_pas].*flag_pas;
pas_remain=pas_remain(pas_remain~=0);
time_cij=zeros(num_driv,size(pas_remain,2)); % 行为车辆，列为待拼车乘客
for I=1:num_driv % 每一辆车
    for J=1:size(time_cij,2) % 每一位待拼车乘客
        [time_cij(I,J),~]=minshare(cars{I,1},pas([2*pas_remain(J)-1,2*pas_remain(J)],:));
    end
end
% 计算每位乘客suff值
suff_pas=zeros(1,size(pas_remain,2));
for J=1:size(suff_pas,2) % 每一位待拼车乘客
    cij_t=time_cij(:,J)';
    [c_min,idx_min]=min(cij_t);
    cij_t(idx_min)=max(cij_t);
    [c_min2,~]=min(cij_t);
    suff_pas(J)=c_min2-c_min;
end
% 为未满客出租车分配待拼车乘客
% 构造num_driv*4的cell矩阵cars，各列分别为：路径、载客编号、总行驶时间、是否满载
T=1;
while sum(flag_pas)~=0 && sum(flag_cars)~=num_driv && T<100
    for I=1:num_driv % 对于每一辆车
        % 判断是否还有乘客
        if sum(flag_pas)==0
            break;
        end
        if cars{I,4}==1
            continue;
        end
        while cars{I,4}~=1
            [~,idx_per_max]=max(suff_pas);
            cars{I,2}=[cars{I,2},pas_remain(idx_per_max)]; % 将suff最大者接上车
            flag_pas(pas_remain(idx_per_max))=0; % 更新待拼车乘客标记
            [cars{I,3},cars{I,1}]=minshare(cars{I,1},pas([2*pas_remain(idx_per_max)-1,2*pas_remain(idx_per_max)],:)); % 更新路径与时间
            % 更新suff数据
            suff_pas(idx_per_max)=0;
            % 判断是否满载
            if size(cars{I,2},2)==max_seats
                cars{I,4}=1;
                flag_cars(I)=1;
            end
        end
    end
    T=T+1;
end
% 计算每一位乘客等待时间
for I=1:num_driv % 对于每一辆车
    for J=1:size(cars{I,2},2) % 每一位乘客
        % 计算等待时间
        t=1; dis_t=0; 
        dis_t=dis_t+dis(cars{I,1}(t,:),pas(2*cars{I,2}(J)-1,:));
        while sum(cars{I,1}(t,:)==pas(2*cars{I,2}(J)-1,:))~=2
            t=t+1;
            dis_t=dis_t+dis(cars{I,1}(t,:),cars{I,1}(t-1,:));
            if t>size(cars{I,1},1)
                break;
            end
        end
        pas_wait(cars{I,2}(J),1)=dis_t/v;
        t=3; dis_t=0; 
        dis_t=dis_t+dis(cars{I,1}(t,:),cars{I,1}(t-1,:));
        while sum(cars{I,1}(t,:)==pas(2*cars{I,2}(J),:))~=2
            dis_t=dis_t+dis(cars{I,1}(t,:),cars{I,1}(t-1,:));
            t=t+1;
            if t>size(cars{I,1},1)
                break;
            end
        end
        pas_wait(cars{I,2}(J),2)=dis_t/v;
    end
end