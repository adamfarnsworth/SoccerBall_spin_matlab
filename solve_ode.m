function [t, y] = solve_ode(f, y0, t_start, t_final, dt)

% Find size of arrays
n_total = ceil((t_final - t_start)/dt);

%size
m = length(y0);

% Create preallocated arrays
y = zeros(m, n_total);
t = zeros(1, n_total);

% Put initial values into arrays
y(:,1) = y0;
t(1) = t_start;

% Initialize auxiliary variable to keep track of the number of iterations
n = 1;

while t(n) < t_final
    
        % Check for overshooting
    if t(n)+dt > t_final
        % If new time t(n+1)=t(n)+dt is greater than t_final we reduce dt
        % so that that new time t(n+1) would be exactly t_final
        dt = t_final-t(n);
    end
    
    % Calculate new time
    t(n+1) = t(n) + dt;
    
    % Calculate all values for RK4 formula
    k1 = f(t(n), y(:,n));
    k2 = f(t(n) + (1/2)*(dt), y(:,n) + (1/2)*(dt)*(k1));
    k3 = f(t(n) + (1/2)*(dt), y(:,n) + (1/2)*(dt)*(k2));
    k4 = f(t(n) + dt, y(:,n) + (dt)*(k3));
       
    % Calculate velocity using RK4 formula
    y(:,n+1) = y(:,n) + (dt)*((k1+(2*k2)+(2*k3)+k4)/6);
    
%     % Calculating velocity using euler formula
%     y(:,n+1)=y(:,n)+dt*f(t(n),y(:,n));


    % Increase total count of iterations
    n = n + 1;
    
end

end