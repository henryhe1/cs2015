function ass1_2017(num_x)

num_x = str2num(num_x);

x = rand(num_x, 1, 'double');
y = randn(num_x, 1, 'double');

subplot(1,2,1);
hist(x,100);
xtitle = ['Histogram of ' num2str(num_x) ' random numbers'];
title(xtitle);
subplot(1,2,2);
hist(y,100);
ytitle = ['Histogram of ' num2str(num_x) ' normal random numbers'];
title(ytitle);

s_x = skewness(x);
s_x2 = my_skewness(x);
k_x = kurtosis(x);
k_x2 = my_kurtosis(x);
s_y = skewness(y);
k_y = kurtosis(y);

% [x, min_x1, max_x1, min_x2, max_x2] = generate_distribution(low_bound_x, high_bound_x, num_x)

end