function [R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
          R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
          R_0_CG]= ...
      CG_calc(R_0_JR3,R_0_JR2,R_0_JR1,R_0_JL3,R_0_JL2,R_0_JL1,robot_para,set_para,RL)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%各部品重心座標計算
%右足　リンク3
R_0_BR3_CG.x=(R_0_JR3.x+R_0_JR2.x)/2;
R_0_BR3_CG.z=(R_0_JR3.z+R_0_JR2.z)/2;
%右足　リンク2
R_0_BR2_CG.x=(R_0_JR2.x+R_0_JR1.x)/2;
R_0_BR2_CG.z=(R_0_JR2.z+R_0_JR1.z)/2;
%右足　足裏
R_0_BRS_CG.x=R_0_JR1.x;
R_0_BRS_CG.z=R_0_JR1.z;

%左足　リンク3
R_0_BL3_CG.x=(R_0_JL3.x+R_0_JL2.x)/2;
R_0_BL3_CG.z=(R_0_JL3.z+R_0_JL2.z)/2;
%左足　リンク2
R_0_BL2_CG.x=(R_0_JL2.x+R_0_JL1.x)/2;
R_0_BL2_CG.z=(R_0_JL2.z+R_0_JL1.z)/2;
%左足　足裏
R_0_BLS_CG.x=R_0_JL1.x;
R_0_BLS_CG.z=R_0_JL1.z;


M_s=robot_para.M_s;%s1_R,s1_L　質量[kg]
M_l23=robot_para.M_l23;%s1_R,s1_L 質量[kg]

   %全体質量[kg]
    M=M_s*2+M_l23*4;

    %全体重心座標[mm]
    %x座標
    R_0_CG.x=(R_0_BR3_CG.x*M_l23+R_0_BR2_CG.x*M_l23+R_0_BRS_CG.x*M_s+ ...
        R_0_BL3_CG.x*M_l23+R_0_BL2_CG.x*M_l23+R_0_BLS_CG.x*M_s)/M;
    %z座標
    R_0_CG.z=(R_0_BR3_CG.z*M_l23+R_0_BR2_CG.z*M_l23+R_0_BRS_CG.z*M_s+ ...
        R_0_BL3_CG.z*M_l23+R_0_BL2_CG.z*M_l23+R_0_BLS_CG.z*M_s)/M;
