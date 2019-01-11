%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������
clear all;close all;clc;clear class

%���{�b�g�̏����ݒ�
robot_para=robot_parameter(); 

%���s�̏����ݒ�
walk_para=walk_parameter();

wT=walk_para.wT;%wT ����[/��]
T=walk_para.T;%T ����ɗv���鎞��[s]
Ts=walk_para.Ts;%Ts �T���v������[s]
x0=walk_para.x0;%x0 ���̏����ʒux���W[mm]
N=walk_para.N;%N ���s���[�V�����J��Ԃ���[-]

%�V�~�����[�V��������
%���ԃx�N�g��
%0<=t<=T:�E�����s  T<t<=2T:�������s
t=0:Ts:2*T;
x=x0;
cmx=60;
cmv=10;
for jj=1:1:N%���s�p�^�[���J��Ԃ���
%���s�p�^�[���v�Z

%���s�p�^�[��(1) �E�����썶���Œ�
%���[x���W[mm]
x=x0+(jj-1)*2*wT;
tp=target_point(x,cmx,cmv,walk_para)
wT=tp.x

    for ii=1:1:(length(t)-1)/2+1   
        y=reference_orbit_acc(t(ii),walk_para);       
        xR=y.xR;
        zR=y.zR;
        %�����̃��[�V�����f�[�^�v�Z    
        motion(ii,jj)=walk_motion_R(x,t(ii),xR,zR,robot_para,walk_para);
        cmx=motion(ii,jj).R_0_CG.x
        
        if ii==1
          %�T���v�����O�ԍ�n=1�̂Ƃ�
          
          %���x�����v�Z
          %R_0_CG(ii).xdot=R_0_CG(ii).x/Ts;
          motion(ii,jj).R_0_CG.xdot=motion(ii,jj).R_0_CG.x/Ts;
        
      end
      
      if (ii>=2)
         
          %���x�����v�Z
          motion(ii,jj).R_0_CG.xdot=(motion(ii,jj).R_0_CG.x-motion(ii-1,jj).R_0_CG.x)/Ts;
      end
      
         
       y.v=motion(ii,jj).R_0_CG.xdot
        cmv=y.v
    end

%���s�p�^�[��(2) ��������E���Œ�
%���[x���W[mm]
x=x0+wT+(jj-1)*2*wT;
tp=target_point(x,cmx,cmv,walk_para)
wT=tp.x

    for ii=(length(t)-1)/2+2:1:length(t)     
        
        xR=y.xR;
        zR=y.zR;
        %�����̃��[�V�����f�[�^�v�Z    
        motion(ii,jj)=walk_motion_L(x,t(ii),xR,zR,robot_para,walk_para);
        
        cmx=motion(ii,jj).R_0_CG.x
        %R_0_CG(ii)=motion(ii,jj).R_0_CG
        cmx=motion(ii,jj).R_0_CG.x
        %q(ii)=motion(ii,jj).R_0_CG
        
        if ii==1
          %�T���v�����O�ԍ�n=1�̂Ƃ�
          
          %���x�����v�Z
          %R_0_CG(ii).xdot=R_0_CG(ii).x/Ts;
          motion(ii,jj).R_0_CG.xdot=motion(ii,jj).R_0_CG.x/Ts;
        
      end
      
      if (ii>=2)
         
          %���x�����v�Z
          %R_0_CG(ii).xdot=(R_0_CG(ii).x-R_0_CG(ii).x)/Ts;
          motion(ii,jj).R_0_CG.xdot=(motion(ii,jj).R_0_CG.x-motion(ii-1,jj).R_0_CG.x)/Ts;
      end
      
         
       y.v=motion(ii,jj).R_0_CG.xdot
        %y=Vel_Acc_calc_forward(ii,motion(ii,jj).R_0_CG,motion(ii-1,jj).R_0_CG,walk_para);
        cmv=y.v
    
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


%�V�~�����[�V�������ʕ`��:�A�j���[�V����
plot_graph;
plot_graph5;
