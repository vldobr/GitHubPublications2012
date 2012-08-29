%% Criterion FQ1 (C14 FQrms) vs. design variable DV1
figure(1)
dv1fq1=[5.55 5.6 5.7 5.79 5.88 5.96 5.99 6.06 6.16 6.26 6.35 6.45 6.55 6.65 6.75 6.85 6.95;
    0.124 0.121 0.116 0.109 0.104 0.099 0.0974 0.094 0.090 0.0855 0.0825 0.079 0.076 0.073 0.07 0.0675 0.066];
plot(dv1fq1(1,:),dv1fq1(2,:),'MarkerFaceColor',[0.749 0 0.749],'MarkerSize',6,...
    'Marker','diamond',...
    'LineWidth',1.25,...
    'Color','k');% raw data

grid on
hold on

dv1fq1_P=[5.96 6.06 6.16 6.26;
    0.099 0.094 0.090 0.0855];
plot(dv1fq1_P(1,:),dv1fq1_P(2,:),'MarkerFaceColor','g','MarkerSize',8,...
    'Marker','o',...
    'LineWidth',1.25,...
    'Color','k');% Pareto data
grad=max(diff(dv1fq1_P(2,:))./diff(dv1fq1_P(1,:)))
dv1fq1_F=[5.99;
    0.0974];
plot(dv1fq1_F(1,:),dv1fq1_F(2,:),'MarkerFaceColor',[1 1 0],'MarkerSize',8,'Marker','o',...
    'LineWidth',1.25,...
    'Color',[0 1 0]);% Optimal point
legend('Feasible solutions','Pareto solutions','#202')

xlabel('Design Variable 1 (PwnAm)')
ylabel('Criterion 14 FQrms-> MIN')

axis([5.5 7 0.06 0.13])

% Create textarrow
annotation('textarrow',[0.2946 0.3714],[0.312 0.5391],...
    'TextEdgeColor','none','FontSize',10,...
    'String',{strcat('\nabla \approx',num2str(grad))});

%% Criterion FQ1 (C14 FQrms) vs. design variable DV1
figure(2)

dv3p3=[13.8 16.7 17.5 21.2 25 28.7 30.6 32.5 36.2;
    0.121 0.1122 0.1106 0.105 0.1005 0.0964 0.0952 0.094 0.092]
plot(dv3p3(1,:),dv3p3(2,:),'MarkerFaceColor',[0.749 0 0.749],'MarkerSize',6,...
    'Marker','diamond',...
    'LineWidth',1.25,...
    'Color','k');% raw data

grid on
hold on

dv3p3_P=[13.8 16.7 17.5 21.2 25 28.7;
    0.121 0.1122 0.1106 0.105 0.1005 0.0964];
plot(dv3p3_P(1,:),dv3p3_P(2,:),'MarkerFaceColor','g','MarkerSize',8,...
    'Marker','o',...
    'LineWidth',1.25,...
    'Color','k');% Pareto data
grad=max(diff(dv3p3_P(2,:))./diff(dv3p3_P(1,:)))

dv3p3_F=[16.7;
    0.1122];
plot(dv3p3_F(1,:),dv3p3_F(2,:),'MarkerFaceColor',[1 1 0],'MarkerSize',8,'Marker','o',...
    'LineWidth',1.25,...
    'Color',[0 1 0]);% Optimal point
legend('Feasible solutions','Pareto solutions','#202')

xlabel('Design Variable 3 (Pcsbw)')
ylabel('Criterion 3 Errnorm L2-> MIN')
axis([10 40 0.08 0.13])

% Create textarrow
annotation('textarrow',[0.3429 0.3054],[0.5381 0.7024],...
    'TextEdgeColor','none','FontSize',10,...
    'String',{strcat('\nabla \approx',num2str(grad))});
