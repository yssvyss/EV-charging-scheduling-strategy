% function []=mainn(number)
clc;clear;

%% ��Ϣ��¼

priceMemory = [];
newTotalPowerMemory = [];
newEVdemandMemory = [];
fvMemory = [];
varMemory = [];

%% ����������Ϣ�͵綯������Ϣ

[gridLoad,EVdemand,vehicle_info,vehicle] = MC();

totalPower = (gridLoad'+EVdemand);
gridLoad = gridLoad';

%% ��������

simulation = [linspace(1,sum(vehicle),sum(vehicle))',vehicle_info,48*ones(sum(vehicle),1)];

simulationFirst = simulation;

%% ��ʱ��۸�ֵ�Լ�ԭʼ���ɱ�

[price,firstCost] = electricityPrice(EVdemand);

priceMemory(:,1) = (price(1:96)')*0.26;
newTotalPowerMemory(:,1) = totalPower;
newEVdemandMemory(:,1) = EVdemand;
varMemory(:,1) = var(totalPower);

%% �û��˳�����

iterations = 10;

for circulation = 1:iterations
    fprintf('��%d�ε�������������������\n',circulation);
    [simulation,fv] = solve(simulation,193,price,firstCost,EVdemand);
    
    % ���µ�ۺ͸���
    newEVdemand = evDemandUpdate(simulation);
    newTotalPower = newEVdemand + gridLoad;
    price = priceUpdateMax(newTotalPower);
    price = [price;price(2:96)]';
    
    if circulation>1
        %         if (abs(fv-max(fvMemory))/max(fvMemory))<0.02%��ͣ
        if (abs(var(newTotalPower)-min(varMemory))/min(varMemory))<0.02%��ͣ
            priceMemory(:,circulation+1) = (price(1,1:96)')*0.26;
            newTotalPowerMemory(:,circulation+1) = newTotalPower;
            newEVdemandMemory(:,circulation+1) = newEVdemand;
            fvMemory(:,circulation) = fv;
            varMemory(:,circulation+1) = var(newTotalPower);
            
            break;
        end
    end
    
    % ��ʷ���ݼ�¼
    
    priceMemory(:,circulation+1) = (price(1,1:96)')*0.26;
    newTotalPowerMemory(:,circulation+1) = newTotalPower;
    newEVdemandMemory(:,circulation+1) = newEVdemand;
    fvMemory(:,circulation) = fv;
    varMemory(:,circulation+1) = var(newTotalPower);
    
end

%% Plot

Plot(gridLoad,EVdemand,totalPower,newTotalPower,newEVdemand,priceMemory(:,size(priceMemory,2)-1));


% end