function LS = fitness(x,n,price,firstCost,simulation,EVdemand)
simulation(:,5)=x';
vehicle_info=simulation;
% input
% vehicle_info = [vehicle No, EnteringTime, ChargingTime, ExitingTime, StartChargingTime]
% n = ʱ�����������+1��
% load_grid = ��������
p=0;
q=1-p;
%% ������Ϣ
N = zeros(n-1,1); % ��ʱ������ڳ���������
P = 7; % ÿ�����ĳ�繦�� [kw]

%% �������ʶ�
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
%% ����ɱ�����

% Ѱ��ÿ��ʱ��ζ����������ڳ��
for  i = 1:n-1
    for j = 1:size(vehicle_info,1)%������
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

% ����С����
% LS = totalpriceEV/firstCost;
LS = p*SSD + q*HF;

end

