function check_wall(y, t_start, t_final, dt, wall_x_start, wall_y_start, wall_x_end, wall_y_end, wall_height)

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
      
    %y position prior the wall needs to be greater than "before"
    %and y position post the wall nees to be  less than "after"
    before = wall_y_start + (y(1,n) - wall_x_start)*(wall_y_end-wall_y_start)/(wall_x_end-wall_x_start);
    after = wall_y_start + (y(1,n+1) - wall_x_start)*(wall_y_end-wall_y_start)/(wall_x_end-wall_x_start);
    
    %checking logic from above
    if((y(2,n)>before) && (y(2,n+1)<after))     
      temp_n = n;
    end
    
    n= n+1;
end



% finding x, y, z positions for n
if (temp_n ~= 0)
    n = temp_n;
   
    %eq1 and eq2 are to clean up the x,y,z position calculations
    eq1 = (y(2,n+1) - y(2,n))/(y(1,n+1) - y(1,n));
    eq2 = (wall_y_end - wall_y_start)/(wall_x_end - wall_x_start);    
    x_cross = (wall_y_start - y(2,n)+y(1,n)*eq1-wall_x_start*eq2)/(eq1-eq2);
    
    y_cross = y(2,n) + (x_cross-y(1,n))*eq1;
    
    eq1 = (y(3,n+1) - y(3,n))/(y(1,n+1) - y(1,n));
    z_cross = y(3,n) + (x_cross-y(1,n))*eq1;

 
end

%seting up boolean to see if x and y will be within the wall bounds
check_x_cross = ((x_cross > wall_x_start) && (x_cross < wall_x_end));
check_y_cross = ((y_cross > wall_y_start) && (y_cross < wall_y_end));

%taking those booleans and checking that z will be within the wall bounds
if( ((check_x_cross) || (check_y_cross)) && (z_cross < wall_height)) 
   disp('hit wall, but if it made it past it would of'); 
else
    disp('made it over wall and');
end


end