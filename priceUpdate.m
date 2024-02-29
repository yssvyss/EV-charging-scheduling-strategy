function [newPrice] = priceUpdate(newTotalPower)

newPrice =zeros(97,1);
%% k��ֵ���ඨ��
% [idx,c] = kmeans(newTotalPower,3);
% 
% %����ͬʱ��¼ԭ����
% [d(:,2),d(:,1)] = sort(c);


%% ģ��c��ֵ���ඨ��

idx = zeros(97,2);
powerMax = max(newTotalPower);
powerMin = min(newTotalPower);

for i = 1:97
newTotalPower2(i,1) = (newTotalPower(i,1)-powerMin)/(powerMax-powerMin);%��һ��
end

options = [NaN NaN NaN 0];
[centers,U] = fcm(newTotalPower2,3,options);

maxU = max(U);
index1 = U(1,:) == maxU;
index2 = U(2,:) == maxU;
index3 = U(3,:) == maxU;



[d(:,2),d(:,1)] = sort(centers);

idx = zeros(97,2);
idx(index1,1) = 1;
idx(index2,1) = 2;
idx(index3,1) = 3;

%% �Ե�۸�ֵ
TOU = [0.2671,0.5021,0.7371];
for k=1:3%����
for i= 1:97
if idx(i,1) == d(k,1)
idx(i,2) = TOU(k);
end
end
end

newPrice = idx(:,2);


end