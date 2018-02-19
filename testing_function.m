clear;
clc;
close all;

%time
t_start = 0;
t_final = 1;

%?t = 0.1, 0.05, 0.025, 0.0125, 0.00625
i=1;
dt = [0.1; 0.05; 0.025; 0.0125; 0.00625];

% initial conditions
y_start = [ 0; 1; 0; 0; 2; 1 ];

f = @(t, y) [y(2);
            sin(1-exp(y(3)));
            1/(1-log(y(5) -1));
            (1/2*t^2+t)*y(2)+exp(y(3))*y(1);
            1-y(5);
            -3*((exp(y(3)-1)/1+t^3))^2; ];

%exact solution
exact_solution = @(t) [ sin(t);
						cos(t); 
						log(1+t);
                        (1/2*(t.^2)+t).*sin(t);
                        1+exp(-t);
                        1./(1+(t.^3)); ];
                    
while i < 6                    
[t, y] = solve_ode(f, y_start, t_start, t_final, dt(i));                    

y_exact = exact_solution(t);


%calculating order
[error] = calculate_max_error(y, y_exact, t_start, t_final, dt(i));
e1 = error;

%this also allows me to get an additional error for an additional order
dt(i) = dt(i)/2;
[t, y] = solve_ode(f, y_start, t_start, t_final, dt(i));
y_exact = exact_solution(t);
[error] = calculate_max_error(y, y_exact, t_start, t_final, dt(i));
e2 = error;


order = log((e1)/(e2))/log(2);
fprintf('dt = %1.5f \nerror = %i \norder of accuracy = %1.5f\n\n', dt(i)*2, e1, order);


i = i +1;
end