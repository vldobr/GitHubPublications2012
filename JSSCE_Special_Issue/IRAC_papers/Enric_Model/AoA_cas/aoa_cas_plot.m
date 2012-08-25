%%Plot the data saved by the Scope blocks
% Common data
t=NLData.time;
aoa_cmd=NLData.signals(1).values(:,2);

%%Complete model
aoa_nl=NLData.signals(1).values(:,1)
q_nl=NLData.signals(2).values(:,1)

%% Reduced model
%%Nonlinear model
aoa_l=LinData.signals(1).values(:,1)
q_l=LinData.signals(2).values(:,1)

%%Plot the data
subplot (2,1,1)
plot(t, aoa_nl,'LineWidth',2,'Color','r'); hold on;
plot(t, aoa_cmd,'LineWidth',2,'Color','b')
grid on
legend('\alpha','\alpha_{cmd}')
axis([0 15 -0.125 1.125])
xlabel('t, sec')
ylabel('\alpha, deg')
% Create textarrow
annotation('textarrow',[0.4078 0.5184],[0.7842 0.8959],...
    'TextEdgeColor','none',...
    'TextLineWidth',1,...
    'FontSize',14,...
    'FontName','Calibri',...
    'String',{' There is no divergence','but a phugoid mode'},...
    'LineWidth',1);

subplot (2,1,2)
plot(t, q_nl,'LineWidth',2)
grid on
legend('q ')
axis([0 15 -2 3])
xlabel('t, sec')
ylabel('q, deg/s')
