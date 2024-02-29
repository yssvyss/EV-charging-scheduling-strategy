% function [gridLoada,EVdemand,vehicle_info,vehicle] = MC()
%�������ؿ���ģ�ⷨģ����綯������������
%ͬʱ���������繦�����ߣ���Ϊ���������ߵĶԱȻ���
% [Ntest, SOC_end,chargePower, Cbattery] = EVinfo();
Ntest=200;%������� ������
SOC_end=1;
chargePower=7;
Cbattery=76.9;%�������

gridLoad=8*xlsread('gridLoad',1,'B10:CT10');
gridLoada = smooth(gridLoad)';
 
vehicle_info = zeros(Ntest,3);%�洢������Ϣ��[���Կ�ʼ���ʱ�� ���ʱ�� ����������ʱ��]
vehicle = zeros(1,192);%����ÿ��ʱ���ڳ��������

% distance=unifrnd(30,150,1,Ntest);%������ɳ��о���
distance=lognrnd(3.2451,0.78,1,Ntest);
judge=0.15*distance/Cbattery;%������кĵ�SOC
SOC=rand(1,Ntest).*(1-judge)+judge;%��ʼSOC

timestart=normrnd(34,0.5,1,Ntest);  %���ʱ��
% timehome=normrnd(18,2,1,Ntest);%�ؼ�ʱ��

timehome=normrnd(19.25,2.7,1,Ntest);           %����ʱ�䣬�������°�߷�·�����ӣ����Բ���Ϊ�°�ؼҺ�ʱ���ϰ��ʱ��ͬ
% timehome=normrnd(17,2.7,1,Ntest);
% SOC=SOC-judge;%���Һ����״̬
SOC=SOC-judge;
battery=SOC*Cbattery;%���Һ�ĵ���

timecharge=zeros(2,Ntest);%��¼���ʱ���


%��¼��翪ʼ����ʱ��
for i=1:Ntest
        timecharge(1,i)=timehome(i);%��ʼʱ��Ϊ����ʱ��
        timecharge(2,i)=timecharge(1,i)+(1-SOC(i))*Cbattery/chargePower;%������ʱ�䣬��繦��7KW
        SOC(i)=SOC_end;%������
        battery(i)=Cbattery*SOC(i);
end
%% ����vehicle_info��vehicle
 
 for i=1:Ntest%����vehicle
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
    nOfChargedEV = size(simulation(find(simulation(:,2) <= i*0.25 & (simulation(:,2)+ simulation(:,3)) > i*0.25)),1);%ֱ������15min����0.25Сʱ
    EVdemand(i+1) = nOfChargedEV*chargePower;
end
EVdemand = EVdemand(1:97) + EVdemand(97:193);

% end