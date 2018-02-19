function [error2] = calculate_max_error(y, y_exact, t_start, t_final, dt)

%error checking code bellow
n_total = ceil((t_final - t_start)/dt);
n = 1;
error = 0;
total = 0;
test = zeros(1, n_total);
while n < n_total

[rows,columns] = size(y);
m=1;
while m < rows

    total = total + (y_exact(m,n)-y(m,n))^2;
    test(n) = test(n) + (y_exact(m,n)-y(m,n))^2;
    m = m+1;
    
end

% max_error = sqrt(total);
% 
% %checking for highest error
% if max_error > error
%     error = max_error;     
% end  

%fixed error
    error2 = sqrt(max(test));
    n = n + 1;
end