clear;
clc;
close all;

%count
j=1;

%spin direction
s1 = [ 0.10; 0.10; -0.99; ];
s2 = [ 0; 0; 1; ];
s3 = [ -0.32; 0; 0.95; ];
s4 = [ 0.10; 0.15; 0.98; ];
bb = [s1 s2 s3 s4];


%mass, gravity lift coeficients
mass = 0.437;
g = 9.81;
c_drag = 0.0057;
c_lift = 0.0061;

%corners of wall start and end 18.1 9.7 17 11.3
wall_x_start = [-11.2; 18.1; -4.3; 12.6;];
wall_y_start = [14.7; 9.7; 25.9; 19.6];
wall_x_end = [-8.6; 17; -.08; 9.9];
wall_y_end = [16; 11.3; 25.9; 20.8];
wall_height = 2;


%goal length and height
goal_length = 7.32;
goal_height = 2.44;


%time
t_start = 0;
t_final = 2;

%change in time
dt = 0.02;


%system of equations
y_start1 =[ -15; 23; 0; 18; -23; 8.5; ];
y_start2 = [ 25.5; 15; 0; -28; -11; 7.5; ];
y_start3 = [ -4; 35; 0; -8; -36; 5; ];
y_start4 = [ 16; 28; 0; -25; -20; 8; ];
bby_start = [y_start1 y_start2 y_start3 y_start4];

%loopoing through all 4 cases
while j < 5

h = @(t,y,s) [ y(4);
               y(5);
               y(6);  
              (-c_drag*sqrt(y(4)^2+y(5)^2+y(6)^2)*y(4) + c_lift*sqrt(y(4)^2+y(5)^2+y(6)^2)*(bb(2,j)*y(6)-bb(3,j)*y(5)))/mass;
              (-c_drag*sqrt(y(4)^2+y(5)^2+y(6)^2)*y(5) + c_lift*sqrt(y(4)^2+y(5)^2+y(6)^2)*(bb(3,j)*y(4)-bb(1,j)*y(6)))/mass;
       (-mass*g-c_drag*sqrt(y(4)^2+y(5)^2+y(6)^2)*y(6) + c_lift*sqrt(y(4)^2+y(5)^2+y(6)^2)*(bb(1,j)*y(5)-bb(2,j)*y(4)))/mass;
              ];

my_h = @(t, y) h(t, y, bb(:,j));

%solve ode
[t,y] = solve_ode(my_h, bby_start(:,j), t_start, t_final, dt);


%3D plot
plot_trajectory(y(1,:),y(2,:),y(3,:), wall_x_start(j), wall_y_start(j), wall_x_end(j), wall_y_end(j), wall_height)
if j ~=4
    figure;
end


%check if it hit wall
fprintf('case number %i ', j);
check_wall(y, t_start, t_final, dt, wall_x_start(j), wall_y_start(j), wall_x_end(j), wall_y_end(j), wall_height);

%check if it made the goal
check_goal(y, t_start, t_final, dt, goal_length, goal_height);
fprintf('\n');

j = j+1;



end

