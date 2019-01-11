function y=reference_orbit_acc(t,walk_para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%reference_orbit_acc.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���s�p�����[�^
wT=walk_para.wT;%����[mm/��]
h=walk_para.h;%��������[mm]
hT=walk_para.hT;%���s���̑��ő卂��[mm]

T=walk_para.T;%����ɗv���鎞��[s]
Ts=walk_para.Ts;%�T���v������[s]

%�Q�ƋO��x���W[mm](x����̑��΍��W)
%�E
if(0<=t&&t<=T)
    %���1
    if(0<=t&&t<=T/2)    
        xR=4*wT/T^2*t^2;
    end
    %���2
    if(T/2<t&&t<=T)    
        xR=wT+4*wT/T*(t-T/2)-4*wT/T^2*(t-T/2)^2;
    end
end

%��
if(T<t&&t<=2*T)
    %���1
    if(T<t&&t<=T*3/2)    
        xR=4*wT/T^2*(t-T)^2;
    end
    %���2
    if(T*3/2<t&&t<=2*T)    
        xR=wT+4*wT/T*(t-T*3/2)-4*wT/T^2*(t-T*3/2)^2;
    end
end

%�Q�ƋO��z���W�̐؂�ւ�
if(0<=xR&&xR<=wT)
    zR=hT/wT*xR;%�E���̈ʒu(z�������̍���)[mm]
elseif(wT<xR&&xR<=2*wT)
    zR=hT-hT/wT*(xR-wT);%�E���̈ʒu(z�������̍���)[mm]
end

%�o�͗p�\���̍쐬
y.xR=xR;
y.zR=zR;

