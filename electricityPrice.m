function [price,firstCost] = electricityPrice(EVdemand)
% [GRIDdemand,EVdemand,totalPower,timecharge,timestart,timehome,vehicle_info,vehicle] = MC;%��ȡvehicle
% [Ntest, SOC_end, Pbiao, Pcharge, Cbattery] = EVinfo();
%% ��ʱ��۸�ֵ
 price=zeros(1,192);
%  first_set= [1:12,33:48,69:84,93:96];
%  for i = 1:length(first_set)
%      j = first_set(i);
%      price(j)=0.521;%ƽ��� 
%  end
%  for j=13:32
%      price(j)=0.218;%�ȵ��
%  end
%  for j=union(49:68,85:92)
%      price(j)=0.825;%����
%  end
%   price(97:192) = price(1:96);
%   
 for i = 1:192
        price(i)=2;
 end

 %% ��ʼ�ɱ�
 firstCost = EVdemand(1:96)' * price(1:96)';
end