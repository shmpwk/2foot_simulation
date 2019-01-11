%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot_graph5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc

figure(20)

for ii=1:1:length(t)
    x2(ii)=R_0_CG(ii).x;
    z2(ii)=R_0_CG(ii).z;
end

subplot(411);plot(t,x2,'r-*','LineWidth',2);title('the entire center of mass x(red*)')
ylabel('position[mm]')
xlabel('time[s]')

subplot(413);plot(t,z2,'b-*','LineWidth',2);title('the entire center of mass z(blue*)')
ylabel('position[mm]')
xlabel('time[s]')

subplot(414);plot(x2,z2,'k-*','LineWidth',2);
xlabel('x[mm]')
ylabel('z[mm]')
title('the position of entire center of mass)(black*)')
grid on
hold off
