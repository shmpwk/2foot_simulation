%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot_graph.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=robot_para.s;%�������A�����̔���
figure(1)
%gcf�Ɏ��ԕ\���p�e�N�X�g�{�b�N�X�ǉ�
ha=annotation('textbox',[0.1 0.1 0.1 0.1]);
 
for ii=1:1:length(t)
        pause(0.1)
   
    %gca�z���ɂ���n���h���I�u�W�F�N�g������
     h = findobj(gca, 'Parent', gca);
     delete(h);

    %�R�����A���A�O���b�h
    view(2) 
    box on
    grid on
    axis square
    

    %���ԕ\��
    time=['time=' num2str(t(ii),'%4.2f') '[s]'];
    set(ha,'String',time);
    
    %�����̍��W�v�Z(�E��)
    R_0_S(1).x=R_0_JR1(ii).x+0;
    R_0_S(3).z=R_0_JR1(ii).z+0;

    R_0_S(2).x=R_0_JR1(ii).x+s;
    R_0_S(2).z=R_0_JR1(ii).z+0;

    R_0_S(3).x=R_0_JR1(ii).x+s;
    R_0_S(3).z=R_0_JR1(ii).z+0;

    R_0_S(4).x=R_0_JR1(ii).x-s;
    R_0_S(4).z=R_0_JR1(ii).z+0;

    R_0_S(5).x=R_0_JR1(ii).x-s;
    R_0_S(5).z=R_0_JR1(ii).z+0;

    %�����̍��W�v�Z(����)
    L_0_S(1).x=R_0_JL1(ii).x+0;
    L_0_S(1).z=R_0_JL1(ii).z+0;

    L_0_S(2).x=R_0_JL1(ii).x+s;
    L_0_S(2).z=R_0_JL1(ii).z+0;

    L_0_S(3).x=R_0_JL1(ii).x+s;
    L_0_S(3).z=R_0_JL1(ii).z+0;

    L_0_S(4).x=R_0_JL1(ii).x-s;
    L_0_S(4).z=R_0_JL1(ii).z+0;

    L_0_S(5).x=R_0_JL1(ii).x-s;
    L_0_S(5).z=R_0_JL1(ii).z+0;

    %�E�����`��
    X=[R_0_S(2).x R_0_S(3).x R_0_S(4).x R_0_S(5).x R_0_S(2).x]; 
    Z=[R_0_S(2).z R_0_S(3).z R_0_S(4).z R_0_S(5).z R_0_S(2).z]; 
    h1=line(X,Z);
    set(h1,'Color','c');
    set(h1,'LineWidth',3);
    hold on %�㏑�����[�h

    %�������`��
    X=[L_0_S(2).x L_0_S(3).x L_0_S(4).x L_0_S(5).x L_0_S(2).x]; 
    Z=[L_0_S(2).z L_0_S(3).z L_0_S(4).z L_0_S(5).z L_0_S(2).z]; 
    h2=line(X,Z);
    set(h2,'Color','m');
    set(h2,'LineWidth',3);

    %�E�G
    X=[R_0_JR1(ii).x R_0_JR2(ii).x]; 
    Z=[R_0_JR1(ii).z R_0_JR2(ii).z]; 
    h3=line(X,Z);
    set(h3,'Color','c');
    set(h3,'LineWidth',3);
   
    %�E��
    X=[R_0_JR2(ii).x R_0_JR3(ii).x]; 
    Z=[R_0_JR2(ii).z R_0_JR3(ii).z]; 
    h4=line(X,Z);
    set(h4,'Color','c');
    set(h4,'LineWidth',3);

    %����
    X=[R_0_JR3(ii).x R_0_JL3(ii).x]; 
    Z=[R_0_JR3(ii).z R_0_JL3(ii).z]; 
    h5=line(X,Z);
    
    %����
    X=[R_0_JL3(ii).x R_0_JL2(ii).x]; 
    Z=[R_0_JL3(ii).z R_0_JL2(ii).z];
    h6=line(X,Z);
    set(h6,'Color','m');
    set(h6,'LineWidth',3);


    %���G
    X=[R_0_JL2(ii).x R_0_JL1(ii).x]; 
    Z=[R_0_JL2(ii).z R_0_JL1(ii).z]; 
    h7=line(X,Z);
    set(h7,'Color','m');
    set(h7,'LineWidth',3);

    set(gca, 'xtick', 0:50:1000);
  
    %�d�S�@�S�́@
    plot3(R_0_CG(ii).x,R_0_CG(ii).z,'*b','MarkerSize',12);
        
    drawnow 

end

%�Q�ƋO��
X=xR_abs(1:length(t)); 
Z=zR(1:length(t));

hold off
