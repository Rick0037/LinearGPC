function Plot_Fxy(name)

directory = name;

Fx = load(['Forces_Data/',directory,'_Fx.mat'],'-ascii');
Umt = load(['Forces_Data/',directory,'_Umt.mat'],'-ascii');

tend = (length(Fx)-1)/10;
time = 0:0.1:tend;
%
%if plt ==1
%figure;
%subplot(3,1,1)
%plot(time,Fx(:,1),'g-',time,Fx(:,2),'b-',time,Fx(:,3),'r-')
%legend 'Fx1' 'Fx2' 'Fx3'
%xlabel 'Time'
%ylabel 'Fx'
%title(['Evolution of Drag on each cylinder over time'])
%
%subplot(3,1,2)
%plot(time,Fy(:,1),'g-',time,Fy(:,2),'b-',time,Fy(:,3),'r-')
%legend 'Fy1' 'Fy2' 'Fy3'
%xlabel 'Time'
%ylabel 'Fy'
%title(['Evolution of Lift on each cylinder over time'])
%
%subplot(3,1,3)
%plot(time,Torque(:,3),'g-')
%hold on
%plot(time,Torque(:,2),'b-')
%plot(time,Torque(:,1),'r-')
%legend 'Torque1' 'Torque2' 'Torque3'
%xlabel 'Time'
%ylabel 'Torque'
%title(['Evolution of the torque on each cylinder over time'])


figure;
subplot(2,2,1)
plot(time,Fx(:,1)+Fx(:,2)+Fx(:,3),'r--')
legend 'Total drag'
xlabel 'Time'
ylabel 'Fx'
title(['Evolution of drag over time'])

subplot(2,2,2)
plot(time,Umt(:,1),'g-')
legend 'b_1(t)'
xlabel 'Time'
ylabel 'b_1'
title(['Control of the first cylinder'])

subplot(2,2,3)
plot(time,Umt(:,2),'b-')
legend 'b_2(t)'
xlabel 'Time'
ylabel 'b_2'
title(['Control of the second cylinder'])

subplot(2,2,4)
plot(time,Umt(:,3),'r-')
legend 'b_2(t)'
xlabel 'Time'
ylabel 'b_3'
title(['Control of the third cylinder'])

end
