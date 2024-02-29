% function []=mainn(number)
clc;clear;

%% 信息记录

priceMemory = [];
newTotalPowerMemory = [];
newEVdemandMemory = [];
fvMemory = [];
varMemory = [];

%% 电力需求信息和电动汽车信息

[gridLoad,EVdemand,vehicle_info,vehicle] = MC();

totalPower = (gridLoad'+EVdemand);
gridLoad = gridLoad';

%% 数据整合

simulation = [linspace(1,sum(vehicle),sum(vehicle))',vehicle_info,48*ones(sum(vehicle),1)];

simulationFirst = simulation;

%% 分时电价赋值以及原始充电成本

[price,firstCost] = electricityPrice(EVdemand);

priceMemory(:,1) = (price(1:96)')*0.26;
newTotalPowerMemory(:,1) = totalPower;
newEVdemandMemory(:,1) = EVdemand;
varMemory(:,1) = var(totalPower);

%% 用户端充电管理

iterations = 10;

for circulation = 1:iterations
    fprintf('第%d次迭代……………………\n',circulation);
    [simulation,fv] = solve(simulation,193,price,firstCost,EVdemand);
    
    % 更新电价和负荷
    newEVdemand = evDemandUpdate(simulation);
    newTotalPower = newEVdemand + gridLoad;
    price = priceUpdateMax(newTotalPower);
    price = [price;price(2:96)]';
    
    if circulation>1
        %         if (abs(fv-max(fvMemory))/max(fvMemory))<0.02%判停
        if (abs(var(newTotalPower)-min(varMemory))/min(varMemory))<0.02%判停
            priceMemory(:,circulation+1) = (price(1,1:96)')*0.26;
            newTotalPowerMemory(:,circulation+1) = newTotalPower;
            newEVdemandMemory(:,circulation+1) = newEVdemand;
            fvMemory(:,circulation) = fv;
            varMemory(:,circulation+1) = var(newTotalPower);
            
            break;
        end
    end
    
    % 历史数据记录
    
    priceMemory(:,circulation+1) = (price(1,1:96)')*0.26;
    newTotalPowerMemory(:,circulation+1) = newTotalPower;
    newEVdemandMemory(:,circulation+1) = newEVdemand;
    fvMemory(:,circulation) = fv;
    varMemory(:,circulation+1) = var(newTotalPower);
    
end

%% Plot

Plot(gridLoad,EVdemand,totalPower,newTotalPower,newEVdemand,priceMemory(:,size(priceMemory,2)-1));


% end