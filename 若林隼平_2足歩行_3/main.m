%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%main.m
%ロボット歩行シミュレーション
%メインルーチン
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%初期化
clear all;close all;clc;clear class

%ロボットの諸元設定
robot_para=robot_parameter(); 

%歩行の諸元設定
walk_para=walk_parameter(0,0);

%シミュレーションの諸元設定
set_para=set_parameter();

wT=walk_para.wT;%wT 歩幅[/歩]
T=walk_para.T;%T 一歩に要する時間[s]
Ts=walk_para.Ts;%Ts サンプル時間[s]
x0=walk_para.x0;%x0 足の初期位置x座標[mm]
N=walk_para.N;%N 歩行モーション繰り返し回数[-]
xR=0;
zR=0;
%w=robot_para.w;%ロボットの腰幅[mm]

%シミュレーション結果表示フラグ
Animation_Enable=set_para.Animation_Enable;

%シミュレーション描画ポーズフラグ
Pause_On=set_para.Plot_Graph_Pause_On;
%シミュレーション描画ポーズサンプル時間
Pause_Sample_Time=set_para.Plot_Graph_Pause_Sample_Time;    

%シミュレーション時間
%時間ベクトル
%0<=t<=T:右足歩行  T<t<=2T:左足歩行
t=0:Ts:2*T;

for jj=1:1:N%歩行パターン繰り返し回数
%歩行パターン計算
%歩行パターン(1) 右足動作左足固定
%左端x座標[mm]
x=x0+(jj-1)*2*wT;

    for ii=1:1:(length(t)-1)/2+1   
        
%        if(Acc_Ref_On==1)
            %両足のモーションデータ計算  
            motion(ii,jj)=walk_motion_R(x,t(ii),xR,zR,robot_para,walk_para,set_para);
            p=motion(ii,jj)
            q=p.R_0_CG.x
            r=p.R_0_BRS_CG.x
            walk_para=walk_parameter(q,r)
            %t(ii)の参照軌道計算
            y=reference_orbit_acc(t(ii),walk_para);
%        else
%            y=reference_orbit(t(ii),walk_para);
%        end
        
        xR=y.xR;
        zR=y.zR;
         
       
    end

%歩行パターン(2) 左足動作右足固定
%左端x座標[mm]
x=x0+wT+(jj-1)*2*wT;

    for ii=(length(t)-1)/2+2:1:length(t)   
         %両足のモーションデータ計算  
            motion(ii,jj)=walk_motion_L(x,t(ii),xR,zR,robot_para,walk_para,set_para);
            p=motion(ii,jj)
            q=p.R_0_CG.x
            r=p.R_0_BLS_CG.x
            walk_para=walk_parameter(q,r)
        %t(ii)の参照軌道計算
%        if(Acc_Ref_On==1)
            y=reference_orbit_acc(t(ii),walk_para);
%        else
%            y=reference_orbit(t(ii),walk_para);
%        end
        
        xR=y.xR;
        zR=y.zR;
        
    end
end

%データ処理
%構造体データ分解
for jj=1:1:N
    for ii=1:1:length(t) 
       R_0_JL1(ii+(jj-1)*length(t))=motion(ii,jj).R_0_JL1;
       R_0_JL2(ii+(jj-1)*length(t))=motion(ii,jj).R_0_JL2;
       R_0_JL3(ii+(jj-1)*length(t))=motion(ii,jj).R_0_JL3;
       R_0_JR1(ii+(jj-1)*length(t))=motion(ii,jj).R_0_JR1;
       R_0_JR2(ii+(jj-1)*length(t))=motion(ii,jj).R_0_JR2;
       R_0_JR3(ii+(jj-1)*length(t))=motion(ii,jj).R_0_JR3;

       xR_abs(ii+(jj-1)*length(t))=motion(ii,jj).xR_abs;      
%       yR(ii+(jj-1)*length(t))=motion(ii,jj).yR;
       zR(ii+(jj-1)*length(t))=motion(ii,jj).zR;
              
       JR3.theta(ii+(jj-1)*length(t))=motion(ii,jj).JR3.theta;
       JR2.theta(ii+(jj-1)*length(t))=motion(ii,jj).JR2.theta;
       JR1.theta(ii+(jj-1)*length(t))=motion(ii,jj).JR1.theta;
       JL3.theta(ii+(jj-1)*length(t))=motion(ii,jj).JL3.theta;
       JL2.theta(ii+(jj-1)*length(t))=motion(ii,jj).JL2.theta;
       JL1.theta(ii+(jj-1)*length(t))=motion(ii,jj).JL1.theta;
       
       R_0_BR3_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_BR3_CG;
       R_0_BR2_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_BR2_CG;
       R_0_BRS_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_BRS_CG;
       R_0_BL3_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_BL3_CG;
       R_0_BL2_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_BL2_CG;
       R_0_BLS_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_BLS_CG;
       R_0_CG(ii+(jj-1)*length(t))=motion(ii,jj).R_0_CG;
    end
end

%for ii=1:1:length(R_0_BR3_CG) 

%速度成分、加速度成分及び速度 計算
% [R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
%  R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
%  R_0_W_CG] = ...
%    Vel_Acc_calc_forward(ii,R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
%        R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
%        R_0_W_CG,walk_para);
%end

for ii=1:1:length(JR3.theta)
%角速度成分、角加速度成分　計算
% [JR3,JR2,JR1,JL3,JL2,JL1] = ...
%    Angular_Vel_Acc_calc_forward(ii,R_0_BRS_CG,R_0_BLS_CG,JR3,JR2,JR1,JL3,JL2,JL1,walk_para);
end

%繰り返し回数Nで時間データを変更 N:最大5最小1
switch(N)
    case 5
    t=[0:Ts:2*T 2*T:Ts:4*T 4*T:Ts:6*T 6*T:Ts:8*T 8*T:Ts:10*T];
    case 4
    t=[0:Ts:2*T 2*T:Ts:4*T 4*T:Ts:6*T 6*T:Ts:8*T];
    case 3
    t=[0:Ts:2*T 2*T:Ts:4*T 4*T:Ts:6*T];
    case 2
    t=[0:Ts:2*T 2*T:Ts:4*T];
    case 1
    t=[0:Ts:2*T];
    otherwise
    t=[0:Ts:2*T];
end

%シミュレーション結果描画:アニメーション
plot_graph;

%シミュレーション結果描画:グラフ
%plot_graph2;

%シミュレーション結果描画:速度/加速度
%if Vel_Acc_Plot_On ==1
%plot_graph3;
%end

%シミュレーション結果描画:角速度/角加速度
%if Angular_Vel_Acc_Plot_On ==1
%plot_graph4;
%end

%シミュレーション結果描画:全体重心、GCoM
%本結果表示は重心調節器の使用フラグONが条件
%if CGCTR_Plot_On ==1
plot_graph5;

%end

%シミュレーション結果保存
%角度データ JR1 JR2 JR3 JL1 JL2 JL3
%時間データ t
%if Motion_Save_On ==1
%save theta_data t JR1 JR2 JR3 JL1 JL2 JL3;
%end
