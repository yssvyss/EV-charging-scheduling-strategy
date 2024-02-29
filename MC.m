% function [gridLoada,EVdemand,vehicle_info,vehicle] = MC()
%利用蒙特卡洛模拟法模拟出电动汽车负荷曲线
%同时求解出无序充电功率曲线，作为有序充电曲线的对比基础
% [Ntest, SOC_end,chargePower, Cbattery] = EVinfo();
Ntest=200;%仿真程序 车辆数
SOC_end=1;
chargePower=7;
Cbattery=76.9;%电池容量

gridLoad=8*xlsread('gridLoad',1,'B10:CT10');
gridLoada = smooth(gridLoad)';
 
vehicle_info = zeros(Ntest,3);%存储汽车信息：[可以开始充电时间 充电时长 必须结束充电时间]
vehicle = zeros(1,192);%储存每个时段在充电汽车数

% distance=unifrnd(30,150,1,Ntest);%随机生成出行距离
distance=lognrnd(3.2451,0.78,1,Ntest);
judge=0.15*distance/Cbattery;%计算出行耗电SOC
SOC=rand(1,Ntest).*(1-judge)+judge;%初始SOC

timestart=normrnd(34,0.5,1,Ntest);  %离家时间
% timehome=normrnd(18,2,1,Ntest);%回家时间

timehome=normrnd(19.25,2.7,1,Ntest);           %到家时间，由于上下班高峰路况复杂，所以不认为下班回家耗时与上班耗时相同
% timehome=normrnd(17,2.7,1,Ntest);
% SOC=SOC-judge;%到家后电量状态
SOC=SOC-judge;
battery=SOC*Cbattery;%到家后的电量

timecharge=zeros(2,Ntest);%记录充电时间点


%记录充电开始结束时间
for i=1:Ntest
        timecharge(1,i)=timehome(i);%开始时间为到家时间
        timecharge(2,i)=timecharge(1,i)+(1-SOC(i))*Cbattery/chargePower;%充电结束时间，充电功率7KW
        SOC(i)=SOC_end;%充满电
        battery(i)=Cbattery*SOC(i);
end
%% 生成vehicle_info和vehicle
 
 for i=1:Ntest%计算vehicle
     if (timecharge(2,i)-timecharge(1,i)~=0)
        a=fix(4*timecharge(1,i));
        vehicle(a) = vehicle(a)+1;
     end
 end
 
vehicle_info = [timecharge(1,:)' ,[timecharge(2,:)'-timecharge(1,:)'] , timestart'];

simulation = [linspace(1,Ntest,Ntest)',vehicle_info,48*ones(sum(vehicle),1)]; 
 %%
nOfIntervals=192;
EVdemand = zeros(nOfIntervals+1,1);
for i = 0:nOfIntervals
    nOfChargedEV = size(simulation(find(simulation(:,2) <= i*0.25 & (simulation(:,2)+ simulation(:,3)) > i*0.25)),1);%直接利用15min等于0.25小时
    EVdemand(i+1) = nOfChargedEV*chargePower;
end
EVdemand = EVdemand(1:97) + EVdemand(97:193);

% end