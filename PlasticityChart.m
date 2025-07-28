clc; clear; close all;

% Plasticity Chart according to USCS
figure('Color','w'); hold on; grid on;

% Axis limits
xlim([0 100]);
ylim([-10 80]);

xlabel('Liquid Limit, LL (%)','FontSize',12);
ylabel('Plasticity Index, PI (%)','FontSize',12);
title('Soil Plasticity Chart (USCS)','FontSize',14,'FontWeight','bold');

%% Lines
LL = 0:100;

% A-Line: PI = 0.73*(LL - 20)
PI_A = 0.73*(LL - 20);
PI_A(PI_A<0)=NaN;

% U-Line: PI = 0.9*(LL - 8)
PI_U = 0.9*(LL - 8);
PI_U(PI_U<0)=NaN;

% Plot A-Line and U-Line
plot(LL,PI_A,'Color',[0.6 0.3 0],'LineWidth',2); % A-Line (brown)
plot(LL,PI_U,'--','Color',[0.6 0.3 0],'LineWidth',1); % U-Line (dotted brown)

% Vertical lines at LL=30 and LL=50
line([30 30],[-10 80],'Color','k','LineWidth',2);
line([50 50],[-10 80],'Color','k','LineWidth',2);

%% Labels for regions
text(20,5,'CL or ML','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);
text(20,20,'CL or OL','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);
text(20,60,'CH or OH','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);
text(65,10,'ML or OL','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);
text(65,35,'MH or OH','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);

% A-Line annotation
text(80,0.73*(80-20)+5,'A-Line','Color',[0.6 0.3 0],'FontSize',10,'FontAngle','italic');

%% Sample Point (Example)
LL_sample = 30; % Example Liquid Limit
PI_sample = 15; % Example Plasticity Index
plot(LL_sample,PI_sample,'p','MarkerSize',12,'MarkerEdgeColor','r','MarkerFaceColor','r');

%% Legend
legend({'A-Line','U-Line','Soil Sample'},'Location','northwest');

set(gca,'FontSize',10,'LineWidth',1.2);
axis([0 100 -10 80]);
