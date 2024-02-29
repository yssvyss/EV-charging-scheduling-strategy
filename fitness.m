function LS = fitness(x,n,price,firstCost,simulation,EVdemand)
simulation(:,5)=x';
vehicle_info=simulation;
% input
% vehicle_info = [vehicle No, EnteringTime, ChargingTime, ExitingTime, StartChargingTime]
% n = 时间点数（段数+1）
% load_grid = 基础负载
p=0;
q=1-p;
%% 基础信息
N = zeros(n-1,1); % 此时间段正在充电的汽车数
P = 7; % 每辆车的充电功率 [kw]

%% 计算舒适度
a1 = 0.2;
a2 = 0.8;
U = zeros(1,97);

newEVdemand = evDemandUpdate(vehicle_info);

for i = union(1:31,88:97)
    Unight(i) = a1 * abs(newEVdemand(i) - EVdemand(i));
    U(i) = Unight(i);
end

for i = 32:87
    Uday(i)= a2 * abs(newEVdemand(i) - EVdemand(i));
    U(i) = Uday(i);
end
    SSD = 1-sum(U)/sum(EVdemand);
%% 计算成本函数

% 寻找每个时间段多少汽车正在充电
for  i = 1:n-1
    for j = 1:size(vehicle_info,1)%车辆数
        if vehicle_info(j,5) <= 0.25*(i-1) && vehicle_info(j,3)+ vehicle_info(j,5) > 0.25*(i-1)
            N(i) = N(i)+1;
        end
    end
%     load_EV(i) = N(i);
    if sum(N) == sum(vehicle_info)
        break
    end
%     load_total(i) = load_EV(i)+load_grid(i);
end 

 totalpriceEV =  price * N * P;
 HF = ((firstCost-totalpriceEV)/firstCost);

% 求最小函数
% LS = totalpriceEV/firstCost;
LS = p*SSD + q*HF;

end

