function newEVdemand = evDemandUpdate(simulation)
timeInterval = 0.25;
% nOfIntervals = 48*60/timeInterval;%ʱ������
nOfIntervals = 48/timeInterval;
newEVdemand = zeros(nOfIntervals+1,1);
P =7;
for i = 0:nOfIntervals
    nOfChargedEV = length(simulation(find(simulation(:,5) <= i*0.25 & (simulation(:,5)+ simulation(:,3)) > i*0.25)));%ֱ������15min����0.25Сʱ
    newEVdemand(i+1) = nOfChargedEV*P;
end
newEVdemand = newEVdemand(1:97) + newEVdemand(97:193);
end