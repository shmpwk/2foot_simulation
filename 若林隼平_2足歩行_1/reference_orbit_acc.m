function y=reference_orbit_acc(t,walk_para)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%reference_orbit_acc.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%歩行パラメータ
wT=walk_para.wT;%歩幅[mm/歩]
h=walk_para.h;%腰部高さ[mm]
hT=walk_para.hT;%歩行時の足最大高さ[mm]

T=walk_para.T;%一歩に要する時間[s]
Ts=walk_para.Ts;%サンプル時間[s]

%参照軌道x座標[mm](xからの相対座標)
%右
if(0<=t&&t<=T)
    %区間1
    if(0<=t&&t<=T/2)    
        xR=4*wT/T^2*t^2;
    end
    %区間2
    if(T/2<t&&t<=T)    
        xR=wT+4*wT/T*(t-T/2)-4*wT/T^2*(t-T/2)^2;
    end
end

%左
if(T<t&&t<=2*T)
    %区間1
    if(T<t&&t<=T*3/2)    
        xR=4*wT/T^2*(t-T)^2;
    end
    %区間2
    if(T*3/2<t&&t<=2*T)    
        xR=wT+4*wT/T*(t-T*3/2)-4*wT/T^2*(t-T*3/2)^2;
    end
end

%参照軌道z座標の切り替え
if(0<=xR&&xR<=wT)
    zR=hT/wT*xR;%右足の位置(z軸方向の高さ)[mm]
elseif(wT<xR&&xR<=2*wT)
    zR=hT-hT/wT*(xR-wT);%右足の位置(z軸方向の高さ)[mm]
end

%出力用構造体作成
y.xR=xR;
y.zR=zR;

