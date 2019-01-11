      
for(ii=1:1:10)
      Ts=5
      m(ii).x=ii*8
      m(ii).z=ii*19
      
      if (ii>=2)
         
          %‘¬“x¬•ªŒvZ
          %R_0_CG(ii).xdot=(R_0_CG(ii).x-R_0_CG(ii).x)/Ts;
          m(ii).xdot=(m(ii).x-m(ii-1).x)/Ts;
      end
end