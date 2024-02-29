function CreateFigureOneColumn
%  设置合适在Word中未分栏时插入图片的格式
%  该函数在Figure图被绘制后使用，绘制Figure图时不要改变线的宽度和标签字体
%  的大小。该函数会统一设置现款为2，字体大小为8.
%   在调用函数之后，需要调用绘图窗口中 Edit->Copy figure 命令，然后粘贴到
%   word

%  使用方法：将该文件保存为.m文件，再MATLAB绘制图形之后，直接运行该文件就行

   set(gcf,'unit','centimeters',...
       'position',[10 5 12 8]);% 设置Figure在屏幕上的位置以及宽度和高
                              % 度，以屏幕的左下角为基准。
                              
%    set(gcf,'color','none');% 设置图像的背景色为透明
   
%    set(gcf,'InvertHardcopy','off');% 硬拷贝转换，‘off’打印输出的结果和
%                                    % 屏幕上显示的（大小）相同
%                                    
%    set(gcf,'paperpositionmode','auto');% In‘manual’mode, MATLAB honors 
%                                        % the value specified by the 
%                                        % PaperPosition property. In‘auto’ 
%                                        % mode, MATLAB prints the figure 
%                                        % the same size as it appears on 
%                                        % the computer screen,centered on
%                                        % the page.
   
   set(gca,'Position',[0.13,0.135,0.8,0.7416]);% 设置坐标轴在Figure中的位置
                                       % （Left，Bottom，Width，Hight）
                                       % Figure的左下角为基准，尺寸的百分比
                                       
%    set(gca,'color','none');% 设置坐标轴区域的背景色为透明
%    
%     FontSize = 12;% 字体大小
%    
%    set(gca,'XLabel','FontSize',10);% 设置X轴标签的大小和位置
% %    
%    set(gca,'YLabel','FontSize',10);% 设置X轴标签的大小和位置
%    
%    set(findobj('FontSize',10),'FontSize',FontSize);
%    
%    set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
% legend1 = legend(axes1,'show');
set(legend,'Location','northwest','FontSize',8);
   
end

 