function y=walk_parameter(cm,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%walk_parameter.m
%   歩行パターンのパラメータ
%必要プロダクト MATLAB
%入力引数
%無し
%出力引数
%y構造体y
%メンバ
%wT 歩幅の半分[/歩]
%h 腰部高さ[mm]
%hT 足最大高さ[mm]
%T 一歩に要する時間[s]
%Ts サンプル時間[s]
%x0 足の初期位置x座標[mm]
%N 歩行モーション繰り返し回数[-]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wT=cm-x;%75;%歩幅の半分[mm/歩]
h=150;%腰部高さ[mm]
hT=50;%足裏参照軌道の最大高さ[mm]

T=0.5;%一歩に要する時間[s]
Ts=0.05;%サンプル時間[s]

x0=0;%足の初期位置x座標[mm]
N=1;%歩行モーション繰り返し回数[-]但し最小1最大5

%歩行パラメータ構造体作成
y.wT=wT;%歩幅の半分[mm/歩]
y.h=h;%腰部高さ[mm]
y.hT=hT;%足裏参照軌道の最大高さ[mm]
y.T=T;%一歩に要する時間[s]
y.Ts=Ts;%サンプル時間[s]
y.x0=x0;%足の初期位置x座標[mm]
y.N=N;%歩行モーション繰り返し回数[-]
