function [x, min_x1, max_x1, min_x2, max_x2] = generate_distribution(low_bound_x, high_bound_x, num_x)

x = rand(num_x,1,'double');
min_x1 = min(x);
max_x1 = max(x);
x = (x - min_x1) / (max_x1 - min_x1);
min_x2 = min(x);
max_x2 = max(x);

if low_bound_x < high_bound_x
    x = x * (high_bound_x - low_bound_x);
    x = x + low_bound_x;
    
else
    fprintf('Error: lower bound not less than higher bound!\n');
    return
end


fprintf('%-14s %d\n%-14s %d\n%-14s %d\n%-14s %d\n%-14s %d\n%-14s %d\n', 'min_x1:', min_x1, 'max_x1:', max_x1, 'min_x2:', min_x2, 'max_x2:', max_x2, 'low_bound_x:', low_bound_x, 'high_bound_x:', high_bound_x);
fprintf('%-14s %d\n%-14s %d\n', 'mean:', mean(x), 'median:', median(x));


return