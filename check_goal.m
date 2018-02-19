function check_goal(y, t_start, t_final, dt, goal_length, goal_height)

%initializing variables
n=1;
temp_n = 0;
n_total = ceil((t_final - t_start)/dt);
t = zeros(1, n_total);
t(1) = t_start;



%finding n where ball crosses axes
while t(n) < t_final
    
    % Check for overshooting
    if t(n)+dt > t_final
        % If new time t(n+1)=t(n)+dt is greater than t_final we reduce dt
        % so that that new time t(n+1) would be exactly t_final
        dt = t_final-t(n);
    end
    
    % Calculate new time
    t(n+1) = t(n) + dt;
       
    %checking what n will be when y crosses the goal
    if((y(2,n)>0) && (y(2,n+1)<0))     
      temp_n = n;
    end
    
    n= n+1;
end



% finding x, y, z positions for n
if (temp_n ~= 0)
    n = temp_n;
    time_cross = -y(2,n)*(t(n+1)-t(n))/(y(2,n+1)-y(2,n)) + t(n);
    x_cross = y(1,n) + (time_cross - t(n))*(y(1,n+1)-y(1,n))/(t(n+1)-t(n));
    z_cross = y(3,n) + (time_cross - t(n))*(y(3,n+1)-y(3,n))/(t(n+1)-t(n));

 
end

%checking to see if a goal was made
if(abs(x_cross) <= goal_length/2 && z_cross <= goal_height) 
   disp('made the goal'); 
else
    disp('missed the goal');
end


end