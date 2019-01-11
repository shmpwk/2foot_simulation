%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%main.m
%���{�b�g���s�V�~�����[�V����
%���C�����[�`��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������
clear all;close all;clc;clear class

%���{�b�g�̏����ݒ�
robot_para=robot_parameter(); 

%���s�̏����ݒ�
walk_para=walk_parameter(0,0);

%�V�~�����[�V�����̏����ݒ�
set_para=set_parameter();

wT=walk_para.wT;%wT ����[/��]
T=walk_para.T;%T ����ɗv���鎞��[s]
Ts=walk_para.Ts;%Ts �T���v������[s]
x0=walk_para.x0;%x0 ���̏����ʒux���W[mm]
N=walk_para.N;%N ���s���[�V�����J��Ԃ���[-]
xR=0;
zR=0;
%w=robot_para.w;%���{�b�g�̍���[mm]

%�V�~�����[�V�������ʕ\���t���O
Animation_Enable=set_para.Animation_Enable;

%�V�~�����[�V�����`��|�[�Y�t���O
Pause_On=set_para.Plot_Graph_Pause_On;
%�V�~�����[�V�����`��|�[�Y�T���v������
Pause_Sample_Time=set_para.Plot_Graph_Pause_Sample_Time;    

%�V�~�����[�V��������
%���ԃx�N�g��
%0<=t<=T:�E�����s  T<t<=2T:�������s
t=0:Ts:2*T;

for jj=1:1:N%���s�p�^�[���J��Ԃ���
%���s�p�^�[���v�Z
%���s�p�^�[��(1) �E�����썶���Œ�
%���[x���W[mm]
x=x0+(jj-1)*2*wT;

    for ii=1:1:(length(t)-1)/2+1   
        
%        if(Acc_Ref_On==1)
            %�����̃��[�V�����f�[�^�v�Z  
            motion(ii,jj)=walk_motion_R(x,t(ii),xR,zR,robot_para,walk_para,set_para);
            p=motion(ii,jj)
            q=p.R_0_CG.x
            r=p.R_0_BRS_CG.x
            walk_para=walk_parameter(q,r)
            %t(ii)�̎Q�ƋO���v�Z
            y=reference_orbit_acc(t(ii),walk_para);
%        else
%            y=reference_orbit(t(ii),walk_para);
%        end
        
        xR=y.xR;
        zR=y.zR;
         
       
    end

%���s�p�^�[��(2) ��������E���Œ�
%���[x���W[mm]
x=x0+wT+(jj-1)*2*wT;

    for ii=(length(t)-1)/2+2:1:length(t)   
         %�����̃��[�V�����f�[�^�v�Z  
            motion(ii,jj)=walk_motion_L(x,t(ii),xR,zR,robot_para,walk_para,set_para);
            p=motion(ii,jj)
            q=p.R_0_CG.x
            r=p.R_0_BLS_CG.x
            walk_para=walk_parameter(q,r)
        %t(ii)�̎Q�ƋO���v�Z
%        if(Acc_Ref_On==1)
            y=reference_orbit_acc(t(ii),walk_para);
%        else
%            y=reference_orbit(t(ii),walk_para);
%        end
        
        xR=y.xR;
        zR=y.zR;
        
    end
end

%�f�[�^����
%�\���̃f�[�^����
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

%���x�����A�����x�����y�ё��x �v�Z
% [R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
%  R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
%  R_0_W_CG] = ...
%    Vel_Acc_calc_forward(ii,R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
%        R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
%        R_0_W_CG,walk_para);
%end

for ii=1:1:length(JR3.theta)
%�p���x�����A�p�����x�����@�v�Z
% [JR3,JR2,JR1,JL3,JL2,JL1] = ...
%    Angular_Vel_Acc_calc_forward(ii,R_0_BRS_CG,R_0_BLS_CG,JR3,JR2,JR1,JL3,JL2,JL1,walk_para);
end

%�J��Ԃ���N�Ŏ��ԃf�[�^��ύX N:�ő�5�ŏ�1
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

%�V�~�����[�V�������ʕ`��:�A�j���[�V����
plot_graph;

%�V�~�����[�V�������ʕ`��:�O���t
%plot_graph2;

%�V�~�����[�V�������ʕ`��:���x/�����x
%if Vel_Acc_Plot_On ==1
%plot_graph3;
%end

%�V�~�����[�V�������ʕ`��:�p���x/�p�����x
%if Angular_Vel_Acc_Plot_On ==1
%plot_graph4;
%end

%�V�~�����[�V�������ʕ`��:�S�̏d�S�AGCoM
%�{���ʕ\���͏d�S���ߊ�̎g�p�t���OON������
%if CGCTR_Plot_On ==1
plot_graph5;

%end

%�V�~�����[�V�������ʕۑ�
%�p�x�f�[�^ JR1 JR2 JR3 JL1 JL2 JL3
%���ԃf�[�^ t
%if Motion_Save_On ==1
%save theta_data t JR1 JR2 JR3 JL1 JL2 JL3;
%end
