function y=Vel_Acc_calc_forward(ii,R_0_CG0,R_0_CG1,walk_para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Vel_Acc_calc_forward.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts=walk_para.Ts;%�T���v������

if ii==1
    %�T���v�����O�ԍ�n=1�̂Ƃ�
    
    %���x�����v�Z
    R_0_CG0(ii).xdot=R_0_CG0(ii).x/Ts;
  
end

if (ii>=2)
   
    %���x�����v�Z
    R_0_CG0(ii).xdot=(R_0_CG0(ii).x-R_0_CG1(ii).x)/Ts;
end

   
 y.v=R_0_CG0(ii).xdot