function [price,firstCost] = electricityPrice(EVdemand)
% [GRIDdemand,EVdemand,totalPower,timecharge,timestart,timehome,vehicle_info,vehicle] = MC;%获取vehicle
% [Ntest, SOC_end, Pbiao, Pcharge, Cbattery] = EVinfo();
%% 分时电价赋值
 price=zeros(1,192);
%  first_set= [1:12,33:48,69:84,93:96];
%  for i = 1:length(first_set)
%      j = first_set(i);
%      price(j)=0.521;%平电价 
%  end
%  for j=13:32
%      price(j)=0.218;%谷电价
%  end
%  for j=union(49:68,85:92)
%      price(j)=0.825;%峰电价
%  end
%   price(97:192) = price(1:96);
%   
 for i = 1:192
        price(i)=2;
 end

 %% 初始成本
 firstCost = EVdemand(1:96)' * price(1:96)';
end