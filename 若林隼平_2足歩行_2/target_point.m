function y=target_point(x,cmx,cmv,walk_para)
  Tsup=walk_para.T;%一歩に要する時間[s]
  zc=75;
  g=9.8
  Tc=sqrt(zc/g)
  C=cosh(Tsup/Tc)
  S=sinh(Tsup/Tc)
  wT=walk_para.wT;%歩幅の半分
  p=x+wT%次の着地目標点
  xd=p+wT*2
  vd=(C+1)/(Tc*S)*p
  a=1
  b=1
  D=a*(C-1)^2+b*(S/Tc)^2
  p=-a*(C-1)/D*(xd-C*cmx-Tc*S*cmv)-b*S/Tc/D*(vd-S/Tc*cmx-C*cmv)
  y.x=p;
endfunction
