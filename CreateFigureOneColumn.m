function CreateFigureOneColumn
%  ���ú�����Word��δ����ʱ����ͼƬ�ĸ�ʽ
%  �ú�����Figureͼ�����ƺ�ʹ�ã�����Figureͼʱ��Ҫ�ı��ߵĿ�Ⱥͱ�ǩ����
%  �Ĵ�С���ú�����ͳһ�����ֿ�Ϊ2�������СΪ8.
%   �ڵ��ú���֮����Ҫ���û�ͼ������ Edit->Copy figure ���Ȼ��ճ����
%   word

%  ʹ�÷����������ļ�����Ϊ.m�ļ�����MATLAB����ͼ��֮��ֱ�����и��ļ�����

   set(gcf,'unit','centimeters',...
       'position',[10 5 12 8]);% ����Figure����Ļ�ϵ�λ���Լ���Ⱥ͸�
                              % �ȣ�����Ļ�����½�Ϊ��׼��
                              
%    set(gcf,'color','none');% ����ͼ��ı���ɫΪ͸��
   
%    set(gcf,'InvertHardcopy','off');% Ӳ����ת������off����ӡ����Ľ����
%                                    % ��Ļ����ʾ�ģ���С����ͬ
%                                    
%    set(gcf,'paperpositionmode','auto');% In��manual��mode, MATLAB honors 
%                                        % the value specified by the 
%                                        % PaperPosition property. In��auto�� 
%                                        % mode, MATLAB prints the figure 
%                                        % the same size as it appears on 
%                                        % the computer screen,centered on
%                                        % the page.
   
   set(gca,'Position',[0.13,0.135,0.8,0.7416]);% ������������Figure�е�λ��
                                       % ��Left��Bottom��Width��Hight��
                                       % Figure�����½�Ϊ��׼���ߴ�İٷֱ�
                                       
%    set(gca,'color','none');% ��������������ı���ɫΪ͸��
%    
%     FontSize = 12;% �����С
%    
%    set(gca,'XLabel','FontSize',10);% ����X���ǩ�Ĵ�С��λ��
% %    
%    set(gca,'YLabel','FontSize',10);% ����X���ǩ�Ĵ�С��λ��
%    
%    set(findobj('FontSize',10),'FontSize',FontSize);
%    
%    set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
% legend1 = legend(axes1,'show');
set(legend,'Location','northwest','FontSize',8);
   
end

 