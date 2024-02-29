function [] = Plot(gridLoad,EVdemand,totalPower,newTotalPower,newEVdemand,price)
%  
xt=0:0.25:24;
figure(1)
subplot(2,2,4),plot(xt,gridLoad,'k--','LineWidth',2);
hold on
plot(xt,totalPower,'b-.','LineWidth',2);
hold on
plot(xt,newTotalPower,'r','LineWidth',2);
hold off
legend('电网基础负荷','无序充电总负荷','有序充电总负荷');
xlim([0 24]);
ylim([10500 20000]);
set(gca,'XTick',[0 4 8 12 16 20 24]);
xlabel('时间/时','FontSize',10);
ylabel('负荷/kW','FontSize',10);
% CreateFigureOneColumn;



xt=0:0.25:24;
figure(2)
subplot(2,2,4),plot(xt,EVdemand,'k-.','LineWidth',2);
hold on
plot(xt,newEVdemand,'b','LineWidth',2);
hold off
legend('无序充电EV负荷','有序充电EV负荷');
xlim([0 24]);
ylim([0 4200])
set(gca,'XTick',[0 4 8 12 16 20 24]);
xlabel('时间/时','FontSize',10);
ylabel('负荷/kW','FontSize',10);
% CreateFigureOneColumn;

figure(3)
x=0:0.25:24;
price = [price;price(96,1)];
subplot(2,2,4),stairs(x,price,'b','Linewidth',2);
xlim([0 24]);
ylim([0 1]);
set(gca,'XTick',[0 4 8 12 16 20 24]);
xlabel('时间/时','FontSize',10);
ylabel('电价/(元/kWh)','FontSize',10);
% CreateFigureOneClumn;


% figure(4)
% x = 1:1:2;
% variance = [var(gridLoad,1) var(totalPower,1) var(newTotalPower,1);var(gridLoad,1) var(totalPower,1) var(newTotalPower,1)];
% bar(x,variance);
% legend('基础负荷','无序充电总负荷','有序充电总负荷');
% ylim([0 4000000]);

end