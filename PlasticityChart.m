clc; clear; close all;

% Plasticity Chart according to USCS
figure('Color','w'); hold on; grid on;

% Axis limits
xlim([0 100]);
ylim([-10 80]);

xlabel('Liquid Limit','FontSize',12);
ylabel('Plasticity Index','FontSize',12);

%% Lines
LL = 0:100;

% A-Line: PI = 0.73*(LL - 20)
PI_A = 0.73*(LL - 20);
PI_A(PI_A<0)=NaN;

% U-Line: PI = 0.9*(LL - 8)
PI_U = 0.9*(LL - 8);
PI_U(PI_U<0)=NaN;

% Plot A-Line and U-Line
h_A = plot(LL,PI_A,'Color',[0.6 0.3 0],'LineWidth',2); % A-Line (brown)

% U-Line (dotted brown) - split to avoid region between PI=4 and PI=7
% Part 1: Below PI=4
LL_below4 = LL(PI_U <= 4 & ~isnan(PI_U));
PI_U_below4 = PI_U(PI_U <= 4 & ~isnan(PI_U));
h_U = plot(LL_below4,PI_U_below4,'--','Color',[0.6 0.3 0],'LineWidth',1);

% Part 2: Above PI=7
LL_above7 = LL(PI_U >= 7 & ~isnan(PI_U));
PI_U_above7 = PI_U(PI_U >= 7 & ~isnan(PI_U));
plot(LL_above7,PI_U_above7,'--','Color',[0.6 0.3 0],'LineWidth',1);

% Vertical line at LL=50 from y=0 to U-Line intersection
PI_at_50 = 0.9*(50 - 8); % U-Line value at LL=50
line([50 50],[0 PI_at_50],'Color','k','LineWidth',2);

% Horizontal brown line at y=0
line([0 100],[0 0],'Color',[0.6 0.3 0],'LineWidth',1);

% Horizontal lines at PI=4 and PI=7 from left until A-Line intersection
% For PI=4: solve 4 = 0.73*(LL-20) -> LL = 4/0.73 + 20
LL_at_PI4 = 4/0.73 + 20;
line([0 LL_at_PI4],[4 4],'Color','k','LineWidth',1);

% For PI=7: solve 7 = 0.73*(LL-20) -> LL = 7/0.73 + 20
LL_at_PI7 = 7/0.73 + 20;
line([0 LL_at_PI7],[7 7],'Color','k','LineWidth',1);

%% Labels for regions
text(10,6,'CL or ML','FontSize',8,'FontWeight','bold','Color',[0.4 0.4 0.4]);
text(30,15,'CL or OL','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4], ...
    'Rotation',atan(0.73)*180/pi);
text(65,40,'CH or OH','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4], ...
    'Rotation',atan(0.73)*180/pi);
text(35,5,'ML or OL','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);
text(70,15,'MH or OH','FontSize',10,'FontWeight','bold','Color',[0.4 0.4 0.4]);

% A-Line annotation - positioned just above the line and rotated to match slope
LL_text = 70;
PI_text = 0.73*(LL_text-20) + 3; % Add 3 units above the line
text(LL_text,PI_text,'A-Line','Color',[0.6 0.3 0],'FontSize',10,'FontAngle', ...
    'italic','Rotation',atan(0.73)*180/pi,'HorizontalAlignment','center');

%% Input LL and PI
LL_sample = 27; 
PI_sample = 13; 
h_sample = plot(LL_sample,PI_sample,'p','MarkerSize',12,'MarkerEdgeColor','r', ...
    'MarkerFaceColor','r');

%% Legend
legend([h_A, h_U, h_sample],{'A-Line','U-Line','Soil Sample'},'Location','northwest');

set(gca,'FontSize',10,'LineWidth',1.2);
axis([0 100 -10 80]);
