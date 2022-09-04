function current_vel = Update_Velocity2(Pos, Vel, Tstep)
         Updater = [ones(1,length(Pos)-1), 0];
         for k = 1:length(Pos)-1
             if (Pos(k) <= 0 && Vel(k)<= 0)||(Pos(k) >= 100 && Vel(k) >= 0)
                 Vel(k) = 0;
             elseif (Pos(k) + Vel(k)*Tstep) > (Pos(k+1) + Vel(k+1)*Tstep) && (Vel(k)*Vel(k+1) > 0)
                 Updater(k) = (abs(Vel(k)) > abs(Vel(k+1)))*(-1) + (abs(Vel(k)) < abs(Vel(k+1)))*(1);
                 Updater(k+1) = (abs(Vel(k)) > abs(Vel(k+1)))*(1) + (abs(Vel(k)) < abs(Vel(k+1)))*(-1);
             elseif (Pos(k) + Vel(k)*Tstep) > (Pos(k+1) + Vel(k+1)*Tstep)  && (Vel(k)*Vel(k+1) < 0)
                 Updater(k) = -1;
                 Updater(k+1) =  -1;
             else
                 continue
             end
         end
         current_vel = Vel.*Updater;
end