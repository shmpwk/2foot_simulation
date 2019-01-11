function y=walk_motion_R(x,t,xR,zR,robot_para,walk_para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%walk_motion_R.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%構造体引数分解
%ロボットパラメータ
l2=robot_para.l2;
l3=robot_para.l3;

%歩行パラメータ
wT=walk_para.wT;
h=walk_para.h;

%左足関節角度計算　逆運動学
temp1=((wT-xR)/2)^2+h^2;
theta_JL2=acos((temp1-(l3^2+l2^2))/(2*l3*l2));
theta_x=asin(l2*sin(theta_JL2)/sqrt(temp1));

temp2=((wT-xR)/2)/sqrt(temp1);
theta_JL3=theta_x+asin(temp2);

%右足関節角度計算　逆運動学
temp3=((wT-xR)/2)^2+(h-zR)^2;
theta_JR2=acos((temp3-(l3^2+l2^2))/(2*l3*l2));
theta_y=asin(l2*sin(theta_JR2)/sqrt(temp3));
temp4=((wT-xR)/2)/sqrt(temp3);
theta_JR3=-theta_y+asin(temp4);

%左足座標計算 順運動学
R_0_JL1.x=x+wT;
R_0_JL1.z=0;
R_0_JL2.x=-sin(theta_JL3-theta_JL2)*l2+x+wT;
R_0_JL2.z=cos(theta_JL3-theta_JL2)*l2;
R_0_JL3.x=-sin(theta_JL3)*l3-sin(theta_JL3-theta_JL2)*l2+x+wT;
R_0_JL3.z=cos(theta_JL3)*l3+cos(theta_JL3-theta_JL2)*l2;

%右足座標計算 順運動学
R_0_JR1.x=x+xR;
R_0_JR1.z=zR;
R_0_JR2.x=sin(theta_JR2+theta_JR3)*l2+x+xR;
R_0_JR2.z=cos(theta_JR2+theta_JR3)*l2+zR;
R_0_JR3.x=sin(theta_JR3)*l3+sin(theta_JR2+theta_JR3)*l2+x+xR;
R_0_JR3.z=cos(theta_JR3)*l3+cos(theta_JR2+theta_JR3)*l2+zR;

%全体重心座標計算
[R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
 R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
 R_0_CG]= ...
 CG_calc(R_0_JR3,R_0_JR2,R_0_JR1,R_0_JL3,R_0_JL2,R_0_JL1,robot_para,'R');

%角度データ加工
%JL3は右足動作時は符号逆転
theta_JL3=-theta_JL3;

%関節角度JL1、JR1の計算
theta_JL1=theta_JL3+theta_JL2;
theta_JR1=(theta_JR2+theta_JR3);

%戻り値構造体作成
y.JR3.theta=theta_JR3;%R3関節角度[rad]
y.JR2.theta=theta_JR2;%R2関節角度[rad]
y.JR1.theta=theta_JR1;%R1関節角度[rad]
y.JL3.theta=theta_JL3;%L3関節角度[rad]
y.JL2.theta=theta_JL2;%L2関節角度[rad]
y.JL1.theta=theta_JL1;%L1関節角度[rad]

y.R_0_JL1=R_0_JL1;%Σ0から見たJL1のxyz座標[x,y,z]'[mm]
y.R_0_JL2=R_0_JL2;%Σ0から見たJL2のxyz座標[x,y,z]'[mm]
y.R_0_JL3=R_0_JL3;%Σ0から見たJL3のxyz座標[x,y,z]'[mm]

y.R_0_JR1=R_0_JR1;%Σ0から見たJR1のxyz座標[x,y,z]'[mm]
y.R_0_JR2=R_0_JR2;%Σ0から見たJR2のxyz座標[x,y,z]'[mm]
y.R_0_JR3=R_0_JR3;%Σ0から見たJR3のxyz座標[x,y,z]'[mm]

y.t=t;%時間[s]
y.xR_abs=xR+x;%Σ0から見た参照軌道のx座標[mm]
y.zR=zR;%Σ0から見た参照軌道のz座標[mm]

y.R_0_BR3_CG=R_0_BR3_CG;%Σ0から見たBR3重心xyz座標[x,y,z]'[mm]
y.R_0_BR2_CG=R_0_BR2_CG;%Σ0から見たBR2重心xyz座標[x,y,z]'[mm]
y.R_0_BRS_CG=R_0_BRS_CG;%Σ0から見たBRS重心xyz座標[x,y,z]'[mm]

y.R_0_BL3_CG=R_0_BL3_CG;%Σ0から見たBL3重心xyz座標[x,y,z]'[mm]
y.R_0_BL2_CG=R_0_BL2_CG;%Σ0から見たBL2重心xyz座標[x,y,z]'[mm]
y.R_0_BLS_CG=R_0_BLS_CG;%Σ0から見たBLS重心xyz座標[x,y,z]'[mm]

y.R_0_CG=R_0_CG;%Σ0から見た全体重心xyz座標[x,y,z]'[mm]
