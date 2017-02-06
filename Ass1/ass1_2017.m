
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Henry He %
% 250869172, hhe65@uwo.ca %
% CS2035, Assignment 1, 2017 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ass1_2017(num_x)

% casting string input to number
num_x = str2num(num_x);

% Step 1: Plotting Histograms
x = rand(num_x, 1, 'double');
y = randn(num_x, 1, 'double');

% Side-by-side plotting
subplot(1,2,1);
hist(x,51);
xtitle = ['Histogram of ' num2str(num_x) ' random numbers'];
title(xtitle);
subplot(1,2,2);
hist(y,51);
ytitle = ['Histogram of ' num2str(num_x) ' normal random numbers'];
title(ytitle);

% Step 2: Skewness and Kurtosis
fprintf('\nSkewness and Kurtosis Calculations\n');
fprintf('----------------------------------\n');
s_x = skewness(x);
fprintf('skewness(x):   %22.12f\n', s_x);
k_x = kurtosis(x);
fprintf('kurtosis(x):   %22.12f\n', k_x);
s_y = skewness(y);
fprintf('skewness(y):   %22.12f\n', s_y);
k_y = kurtosis(y);
fprintf('kurtosis(y):   %22.12f\n\n', k_y);

s_x2 = my_skewness(x);
fprintf('my_skewness(x):%22.12f\n', s_x2);
k_x2 = my_kurtosis(x);
fprintf('my_kurtosis(x):%22.12f\n', k_x2);
s_y2 = my_skewness(y);
fprintf('my_skewness(y):%22.12f\n', s_y2);
k_y2 = my_kurtosis(y);
fprintf('my_kurtosis(y):%22.12f\n', k_y2);

% Step 3: Generate Distribution

fprintf('\nGenerate Distribution Calculations\n');
fprintf('----------------------------------\n');

% given in class
low_bound_x = 0;
high_bound_x = 1000000;

[x, min_x1, max_x1, min_x2, max_x2] = ... 
    generate_distribution(low_bound_x, high_bound_x, num_x);

% pretty print everything
fprintf('%-14s %22.12f\n%-14s %22.12f\n%-14s %22d\n%-14s %22d\n%-14s %22d\n%-14s %22d\n', ...
    'min_x1:', min_x1, 'max_x1:', max_x1, 'min_x2:', min_x2, 'max_x2:', ...
    max_x2, 'low_bound_x:', low_bound_x, 'high_bound_x:', high_bound_x);

fprintf('%-14s %22.12f\n%-14s %22.12f\n', 'mean:', mean(x), 'median:', median(x));

% Step 4: Difference of sums

fprintf('\nDifference of Sums Calculations\n');
fprintf('-------------------------------\n');
normal_sum = sum(x);
fprintf('%-14s %22d', 'sum(x):', normal_sum);
sorted_sum = sum(sort(x));
fprintf('\n%-14s %22d', 'sum(sort(x)):', sorted_sum);
fprintf('\n%-14s %22.12f', 'difference:', sum(sort(x)) - sum(x));
fprintf('\n');

% The difference of sums is not zero due to roundoff errors with the sum
% and sort builtin functions, as x becomes larger. I would expect the
% sorted sum to be more accurate.

% Step 5: Relative zero

fprintf('\nRelative Zero Calculations\n');
fprintf('--------------------------\n');

b = 1.0e64;
a = 10000000; %relative zero for 1.0e64


fprintf('%-14s %22d', 'a:', a);
fprintf('\n%-14s %22d', 'b:', b);
fprintf('\n%-14s %22d', 'a + b = ', a + b);

% Checking equality
if a + b == b
    fprintf('\nTherefore %d is a relative zero for %d.', a, b);
else
    fprintf('%d is NOT a relative zero for %d', a, b);
end

fprintf('\n');


end

function s = my_skewness(x)

    % find avg
    sum = 0;
    for i=1:length(x)
       sum = sum + x(i);
    end
    avg = sum / length(x);

    %the skewness formula
    sum1 = 0;
    sum2 = 0;
    for i=1:length(x)
       sum1 = sum1 + (x(i) - avg)^ 3; 
       sum2 = sum2 + (x(i) - avg)^ 2;
    end

    numerator = sum1 / length(x);
    denominator = (sqrt( sum2 / length(x) ))^3;

    s = numerator / denominator;

end

function k = my_kurtosis(x)

    % find avg
    sum = 0;
    for i=1:length(x)
       sum = sum + x(i);
    end
    avg = sum / length(x);

    % kurtosis formula
    sum1 = 0;
    sum2 = 0;
    for i=1:length(x)
       sum1 = sum1 + (x(i) - avg)^ 4; 
       sum2 = sum2 + (x(i) - avg)^ 2;
    end

    numerator = sum1 / length(x);
    denominator = ( sum2 / length(x) )^2;

    k = numerator / denominator;

end

function [x, min_x1, max_x1, min_x2, max_x2] = ...
    generate_distribution(min_val, max_val, n)

    x = rand(n,1,'double');
    min_x1 = min(x);
    max_x1 = max(x);

    %scale x to be precisely between 0 and 1
    x = (x - min_x1) / (max_x1 - min_x1);
    
    %should be precisely 0 and 1
    min_x2 = min(x);
    max_x2 = max(x);

    %scale x to be between min_val and max_val
    if min_val < max_val % error checking
        x = x * (max_val - min_val);
        x = x + min_val;
    else
        fprintf('Error: lower bound not less than higher bound!\n');
        return %exit loop
    end

end
