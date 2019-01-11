function y=walk_motion_R(x,t,xR,zR,robot_para,walk_para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%walk_motion_R.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�\���̈�������
%���{�b�g�p�����[�^
l2=robot_para.l2;
l3=robot_para.l3;

%���s�p�����[�^
wT=walk_para.wT;
h=walk_para.h;

%�����֐ߊp�x�v�Z�@�t�^���w
temp1=((wT-xR)/2)^2+h^2;
theta_JL2=acos((temp1-(l3^2+l2^2))/(2*l3*l2));
theta_x=asin(l2*sin(theta_JL2)/sqrt(temp1));

temp2=((wT-xR)/2)/sqrt(temp1);
theta_JL3=theta_x+asin(temp2);

%�E���֐ߊp�x�v�Z�@�t�^���w
temp3=((wT-xR)/2)^2+(h-zR)^2;
theta_JR2=acos((temp3-(l3^2+l2^2))/(2*l3*l2));
theta_y=asin(l2*sin(theta_JR2)/sqrt(temp3));
temp4=((wT-xR)/2)/sqrt(temp3);
theta_JR3=-theta_y+asin(temp4);

%�������W�v�Z ���^���w
R_0_JL1.x=x+wT;
R_0_JL1.z=0;
R_0_JL2.x=-sin(theta_JL3-theta_JL2)*l2+x+wT;
R_0_JL2.z=cos(theta_JL3-theta_JL2)*l2;
R_0_JL3.x=-sin(theta_JL3)*l3-sin(theta_JL3-theta_JL2)*l2+x+wT;
R_0_JL3.z=cos(theta_JL3)*l3+cos(theta_JL3-theta_JL2)*l2;

%�E�����W�v�Z ���^���w
R_0_JR1.x=x+xR;
R_0_JR1.z=zR;
R_0_JR2.x=sin(theta_JR2+theta_JR3)*l2+x+xR;
R_0_JR2.z=cos(theta_JR2+theta_JR3)*l2+zR;
R_0_JR3.x=sin(theta_JR3)*l3+sin(theta_JR2+theta_JR3)*l2+x+xR;
R_0_JR3.z=cos(theta_JR3)*l3+cos(theta_JR2+theta_JR3)*l2+zR;

%�S�̏d�S���W�v�Z
[R_0_BR3_CG,R_0_BR2_CG,R_0_BRS_CG, ...
 R_0_BL3_CG,R_0_BL2_CG,R_0_BLS_CG, ...
 R_0_CG]= ...
 CG_calc(R_0_JR3,R_0_JR2,R_0_JR1,R_0_JL3,R_0_JL2,R_0_JL1,robot_para,'R');

%�p�x�f�[�^���H
%JL3�͉E�����쎞�͕����t�]
theta_JL3=-theta_JL3;

%�֐ߊp�xJL1�AJR1�̌v�Z
theta_JL1=theta_JL3+theta_JL2;
theta_JR1=(theta_JR2+theta_JR3);

%�߂�l�\���̍쐬
y.JR3.theta=theta_JR3;%R3�֐ߊp�x[rad]
y.JR2.theta=theta_JR2;%R2�֐ߊp�x[rad]
y.JR1.theta=theta_JR1;%R1�֐ߊp�x[rad]
y.JL3.theta=theta_JL3;%L3�֐ߊp�x[rad]
y.JL2.theta=theta_JL2;%L2�֐ߊp�x[rad]
y.JL1.theta=theta_JL1;%L1�֐ߊp�x[rad]

y.R_0_JL1=R_0_JL1;%��0���猩��JL1��xyz���W[x,y,z]'[mm]
y.R_0_JL2=R_0_JL2;%��0���猩��JL2��xyz���W[x,y,z]'[mm]
y.R_0_JL3=R_0_JL3;%��0���猩��JL3��xyz���W[x,y,z]'[mm]

y.R_0_JR1=R_0_JR1;%��0���猩��JR1��xyz���W[x,y,z]'[mm]
y.R_0_JR2=R_0_JR2;%��0���猩��JR2��xyz���W[x,y,z]'[mm]
y.R_0_JR3=R_0_JR3;%��0���猩��JR3��xyz���W[x,y,z]'[mm]

y.t=t;%����[s]
y.xR_abs=xR+x;%��0���猩���Q�ƋO����x���W[mm]
y.zR=zR;%��0���猩���Q�ƋO����z���W[mm]

y.R_0_BR3_CG=R_0_BR3_CG;%��0���猩��BR3�d�Sxyz���W[x,y,z]'[mm]
y.R_0_BR2_CG=R_0_BR2_CG;%��0���猩��BR2�d�Sxyz���W[x,y,z]'[mm]
y.R_0_BRS_CG=R_0_BRS_CG;%��0���猩��BRS�d�Sxyz���W[x,y,z]'[mm]

y.R_0_BL3_CG=R_0_BL3_CG;%��0���猩��BL3�d�Sxyz���W[x,y,z]'[mm]
y.R_0_BL2_CG=R_0_BL2_CG;%��0���猩��BL2�d�Sxyz���W[x,y,z]'[mm]
y.R_0_BLS_CG=R_0_BLS_CG;%��0���猩��BLS�d�Sxyz���W[x,y,z]'[mm]

y.R_0_CG=R_0_CG;%��0���猩���S�̏d�Sxyz���W[x,y,z]'[mm]
