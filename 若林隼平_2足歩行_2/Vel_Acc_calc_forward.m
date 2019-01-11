function y=Vel_Acc_calc_forward(ii,R_0_CG0,R_0_CG1,walk_para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Vel_Acc_calc_forward.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts=walk_para.Ts;%サンプル時間

if ii==1
    %サンプリング番号n=1のとき
    
    %速度成分計算
    R_0_CG0(ii).xdot=R_0_CG0(ii).x/Ts;
  
end

if (ii>=2)
   
    %速度成分計算
    R_0_CG0(ii).xdot=(R_0_CG0(ii).x-R_0_CG1(ii).x)/Ts;
end

   
 y.v=R_0_CG0(ii).xdot