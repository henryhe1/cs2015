function k = my_kurtosis(x)

% find avg
sum = 0;
for i=1:length(x)
   sum = sum + x(i);
end
avg = sum / length(x);



sum1 = 0;
sum2 = 0;
for i=1:length(x)
   sum1 = sum1 + (x(i) - avg)^ 4; 
   sum2 = sum2 + (x(i) - avg)^ 2;
end

numerator = sum1 / length(x);
denominator = ( sum2 / length(x) )^2;

k = numerator / denominator;


return