function [newPrice] = priceUpdateMax(newTotalPower)
swich = 2;
newPrice =zeros(97,1);
d = zeros(4,2);
%  newTotalPower=smooth(5*xlsread('gridLoad',1,'B10:CT10')');
% newTotalPower=xlsread('gridLoad',1,'B10:CT10')';
newTotalPower=smooth(newTotalPower);
if swich == 1
    %% k均值聚类定价
    opts = statset('Display','final');
    [idx,c,sumD,D] = kmeans(newTotalPower,4,'Replicates',1,'Options',opts);
    

    %排序，同时记录原次序
    [d(:,2),d(:,1)] = sort(c);
    
%     idxx = 10*idx;
%     idxx(idxx==10*d(1,1))=1;
%     idxx(idxx==10*d(2,1))=2;
%     idxx(idxx==10*d(3,1))=2;
%     idxx(idxx==10*d(4,1))=2;
%     idxx(idxx==10*d(5,1))=3;
    
    figure(100);
    [silh3,h] = silhouette(newTotalPower,idx);
    h = gca;
    h.Children.EdgeColor = [.8 .8 1];
    xlabel 'Silhouette Value'
    ylabel 'Cluster'
    
elseif swich == 2
    
 %% 模糊c均值聚类定价
    idx = zeros(97,2);
    powerMax = max(newTotalPower);
    powerMin = min(newTotalPower);
    
    for i = 1:97
        newTotalPower2(i,1) = (newTotalPower(i,1)-powerMin)/(powerMax-powerMin);
    end
    
    options = [NaN NaN NaN 0];
    [centers,U,obj_fcn] = fcm(newTotalPower2,4,options);
    
    %找出来哪一类
    maxU = max(U);
    %找出来每个最大隶属度，在idx中标号，与center对应
    % index1 = U(1,:) == maxU;
    % index2 = U(2,:) == maxU;
    % index3 = U(3,:) == maxU;
    % index4 = U(4,:) == maxU;
    % index5 = U(5,:) == maxU;
    % idx(index1,1) = 1;
    % idx(index2,1) = 2;
    % idx(index3,1) = 3;
    % idx(index4,1) = 4;
    % idx(index5,1) = 5;
    %也即
    % for n = 1:1:5
    %     index(n,:) = U(n,:)==maxU;
    %     idx(index(n,:),1) = n;
    % end
    for n = 1:1:4
        idx(U(n,:)==maxU,1) = n;
    end
    
    [d(:,2),d(:,1)] = sort(centers);
    
%     figure(100);
%    [silh3,h] = silhouette(newTotalPower,idx(:,1));
%     h = gca;
%     h.Children.EdgeColor = [.8 .8 1];
%     xlabel 'Silhouette Value'
%     ylabel 'Cluster'
    
end
%% 对电价赋值
% TOU = [0.26,0.50,0.78];
TOU = [1,2 3];
for k=1:3%几档
    if k==1
        for i= 1:97
            if idx(i,1) == d(1,1)
                idx(i,2) = TOU(1);
            end
        end
        
    elseif  k==2
        for i= 1:97
            if (idx(i,1) == d(2,1))||(idx(i,1) == d(3,1))
                idx(i,2) = TOU(2);
            end
        end
        
    elseif k==3
        for i= 1:97
            if idx(i,1) == d(4,1)
                idx(i,2) = TOU(3);
            end
        end
    end
end


newPrice = idx(:,2);

% figure(101);
% x=0:0.25:24;
% stairs(x,newPrice,'Linewidth',2);
% xlim([0 24]);
% ylim([0 1]);
% set(gca,'XTick',[0 4 8 12 16 20 24]);
% xlabel('时间/时');
% ylabel('电价/元');

end