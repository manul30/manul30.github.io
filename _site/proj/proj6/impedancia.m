clear, close all, clc;

set(0,'DefaultLineLineWidth', 2)

titlelabelsize = 17;
xylabelsize = 12.5;
legendlabelsize = 10;
markersize = 15;

data = importdata('impendace_controller.txt');  
X = data(:,2) ; Y = data(:,3) ; Z = data(:,4) ; T0 = data(:,5) ; T1 = data(:,6) ; T2 = data(:,7) ; T3 = data(:,8) ;
X = X*100; Y = Y*100; Z = Z*100;

time = 0:0.01:length(X)*0.01-0.01;
time = time';

Xdes = 0.286*100;
Ydes = 0.0 * 100;
Zdes = 0.2045*100;
un = ones(length(time),1);

figure,
subplot(3,1,1); 
plot(time,X); title("Posicion X");ylabel("Posicion_X(cm)"); axis([0 time(end) 15 40]) ; grid on; hold on;
plot(time,un*Xdes);

subplot(3,1,2);
plot(time,Y); title("Posicion Y");ylabel("Posicion_Y(cm)"); axis([0 time(end) -20 20])  ; grid on; hold on;
plot(time,un*Ydes);

subplot(3,1,3);
plot(time,Z); title("Posicion Z");ylabel("Posicion_Z(cm)"); axis([0 time(end) 5 35])  ; xlabel("Tiempo(S)"); grid on; hold on;
plot(time,un*Zdes);

%%
figure,
subplot(4,1,1); 
plot(time,T0); title("\tau_0");ylabel("Posicion_X(cm)") ; grid on; hold on;

subplot(4,1,2);
plot(time,T1); title("\tau_1");ylabel("Posicion_Y(cm)") ; grid on; hold on;

subplot(4,1,3);
plot(time,T2); title("\tau_2");ylabel("Posicion_Z(cm)") ; grid on; hold on;

subplot(4,1,4);
plot(time,T3); title("\tau_3");ylabel("Posicion_Z(cm)") ; xlabel("Tiempo(S)"); grid on; hold on;

%%
fg3 = figure(3); clf;
set(gcf,'Color','w') 
tq = tiledlayout(3,1);
xlabel(tq,'Tiempo [s]','FontSize',xylabelsize)
%ylabel(tq,'Posicion [cm]','FontSize',xylabelsize)
%title(tq,'Estados predecidos vs medidos','FontSize',13)
dax1 = nexttile;
    hold on;    
    plot(time,un*Xdes); hold on; plot(time,X,"--"); 
    %xlabel('Time [s]','FontSize',xylabelsize)
    ylabel('Posicion [cm]','FontSize',xylabelsize)
    title('X','FontSize',titlelabelsize)
    %axis([0 time(end) 0 40]);
    xlim([0 time(end)]); 
    %ylim([]);
    grid on;
    hold off;

dax2 = nexttile;
    hold on;    
    plot(time,un*Ydes); hold on; plot(time,Y,"--"); 
    %xlabel('Time [s]','FontSize',xylabelsize)
    ylabel('Posicion [cm]','FontSize',xylabelsize)
    title('Y','FontSize',titlelabelsize)
    %axis([0 time(end) 0 40]);
    xlim([0 time(end)]); 
    %ylim([]);
    grid on;
    hold off;

dax3 = nexttile;
    hold on;    
    plot(time,un*Zdes); hold on; plot(time,Z,"--"); 
    %xlabel('Time [s]','FontSize',xylabelsize)
    ylabel('Posicion [cm]','FontSize',xylabelsize)
    title('Z','FontSize',titlelabelsize)
    %axis([0 time(end) 0 40]);
    xlim([0 time(end)]); 
    %ylim([]);
    grid on;
    hold off;

%axis([dax1],[0 150 0 1.5]);
%axis([dax2],[0 150 -4 4]);
algnd = legend({'Deseado','Medido'},'FontSize',legendlabelsize,'Orientation','horizontal');
algnd.Layout.Tile = 'North';

%%
fg4 = figure(4); clf;
set(gcf,'Color','w') 

plot3(X,Y,Z);
%title('Trajectory of end effector','FontSize',titlelabelsize);
xlabel('x [m]','FontSize',xylabelsize), ylabel('y [m]','FontSize',xylabelsize), zlabel('z [m]','FontSize',xylabelsize), grid on;
%legend({'Initial Point','Final Point','Desired',tag1,tag2,tag3},'FontSize',legendlabelsize)

%%

X1 = X(682:969);
Y1 = Y(682:969);

fg4 = figure(4); clf;
set(gcf,'Color','w') 
plot(X1,Y1); hold on;
plot(X1(1),Y1(1),'.','MarkerSize',markersize), plot(X1(end),Y1(end),'x','MarkerSize',markersize);
xlabel('x [m]','FontSize',xylabelsize), ylabel('y [m]','FontSize',xylabelsize);