%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Henry He %
% 250869172, hhe65@uwo.ca %
% CS2035, Assignment 2, 2017 %
% Feb 26, 2017 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ass2_2017(num_x)

    % casting string input to number
    num_x = str2double(num_x);

    % Generate uniformly distributed random numbers
    x = rand(num_x, 1, 'double');
    % Generate normally distibuted random numbers
    y = randn(num_x, 1, 'double');


    % Skewness and Kurtosis Calculations with runtime 
    % Matlab built-in functions
    start=tic;
    s_x = skewness(x);
    finish1 = toc(start);

    start=tic;
    k_x = kurtosis(x);
    finish2 = toc(start);

    start=tic;
    s_y = skewness(y);
    finish3 = toc(start);

    start=tic;
    k_y = kurtosis(y);
    finish4 = toc(start);

    %Serialized functions from assignment 1
    start=tic;
    s_x2 = my_skewness(x);
    finish5 = toc(start);

    start=tic;
    k_x2 = my_kurtosis(x);
    finish6 = toc(start);

    start=tic;
    s_y2 = my_skewness(y);
    finish7 = toc(start);

    start=tic;
    k_y2 = my_kurtosis(y);
    finish8 = toc(start);

    % New vectorized functions for assignment 2
    start=tic;
    s_x3 = my_skewness2(x);
    finish9 = toc(start);

    start=tic;
    k_x3 = my_kurtosis2(x);
    finish10 = toc(start);

    start=tic;
    s_y3 = my_skewness2(y);
    finish11 = toc(start);

    start=tic;
    k_y3 = my_kurtosis2(y);
    finish12 = toc(start);

    % Mystery function calculations with runtime
    start=tic;
    mystery_vector1 = vectorized_mystery_calculation(x,y);
    finish13 = toc(start);

    start=tic;
    mystery_vector2 = vectorized_mystery_calculation(y,x);
    finish14 = toc(start);

    start=tic;
    mystery_serial1 = serialized_mystery_calculation(x,y);
    finish15 = toc(start);

    start=tic;
    mystery_serial2 = serialized_mystery_calculation(y,x);
    finish16 = toc(start);

    % Pretty Printed console output
    fprintf('\nSkewness and Kurtosis Calculations\n');
    fprintf('----------------------------------\n');
    fprintf('skewness(x):                           %20.10f        serial time: %f\n', s_x, finish1);
    fprintf('kurtosis(x):                           %20.10f        serial time: %f\n', k_x, finish2);
    fprintf('skewness(y):                           %20.10f        serial time: %f\n', s_y, finish3);
    fprintf('kurtosis(y):                           %20.10f        serial time: %f\n\n', k_y, finish4);

    fprintf('my_skewness(x):                        %20.10f        serial time: %f\n', s_x2, finish5);
    fprintf('my_kurtosis(x):                        %20.10f        serial time: %f\n', k_x2, finish6);
    fprintf('my_skewness(y):                        %20.10f        serial time: %f\n', s_y2, finish7);
    fprintf('my_kurtosis(y):                        %20.10f        serial time: %f\n\n', k_y2, finish8);

    fprintf('my_skewness2(x):                       %20.10f        serial time: %f\n', s_x3, finish9);
    fprintf('my_kurtosis2(x):                       %20.10f        serial time: %f\n', k_x3, finish10);
    fprintf('my_skewness2(y):                       %20.10f        serial time: %f\n', s_y3, finish11);
    fprintf('my_kurtosis2(y):                       %20.10f        serial time: %f\n\n', k_y3, finish12);

    fprintf('vectorized_mystery_calculation(x,y):   %20.10f        serial time: %f\n', mystery_vector1, finish13);
    fprintf('vectorized_mystery_calculation(y,x):   %20.10f        serial time: %f\n', mystery_vector2, finish14);
    fprintf('serialized_mystery_calculation(x,y):   %20.10f        serial time: %f\n', mystery_serial1, finish15);
    fprintf('serialized_mystery_calculation(y,x):   %20.10f        serial time: %f\n\n', mystery_serial2, finish16);

    fprintf('Mean speedup of MatLab skewness/kurtosis over serialized: %f\n', (finish5 + finish6 + finish7 + finish8) / (finish1 + finish2 + finish3 + finish4));
    fprintf('Mean speedup of vectorized over MatLab skewness/kurtosis: %f\n', (finish1 + finish2 + finish3 + finish4) / (finish9 + finish10 + finish11 + finish12));
    fprintf('Mean speedup of vectorized over serialized skewness/kurtosis: %f\n',(finish5 + finish6 + finish7 + finish8) / (finish9 + finish10 + finish11 + finish12));

    fprintf('Mean speedup of vectorized over serialized mystery_calculation(x,y): %f\n\n',(finish15 + finish16)/ (finish13 + finish14));

end

% This function calculates the skewness of a 1D array according to the
% formula used by MATLAB's skewness function, in a serialized manner.
function s = my_skewness(x)

    % find avg loop 
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

% This function calculates the kurtosis of a 1D vector according to the
% formula used by MATLAB's kurtosis function, in a serialized manner.
function k = my_kurtosis(x)

    % find avg loop
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


% NEW CODE FOR ASSIGNMENT 2***************************


% This function calculates the skewness of a 1D vector according to the
% formula used by MATLAB's skewness function, in a vectorized manner.
function s = my_skewness2(x)
    
    s = ( sum((x-mean(x)).^3) / numel(x)) / ( sqrt( sum((x-mean(x)).^2) / numel(x) ))^3 ;
    
end

% This function calculates the kurtosis of a 1D vector according to the
% formula used by MATLAB's kurtosis function, in a vectorized manner.
function k = my_kurtosis2(x)
    
    k = ( sum( (x-mean(x)).^4) / numel(x) ) / ( sum( (x-mean(x)).^2 / numel(x) )^2 ) ;

end

% This function calculates the result of a mystery calculation, the formula
% of which is given in the document ass2_2017.pdf, in a vectorized manner
function result = vectorized_mystery_calculation(x,y)

    result = sum( (  ( (2*x) .* (2 - y)).^(1/3)  ./  (  ( (x.^2).*(y.^3) ).^(1/4) + 5  ).^(1/6)  ).^(1/9) );

end

% This function calculates the result of a mystery calculation, the formula
% of which is given in the document ass2_2017.pdf, in a serialized manner
function [value]=serialized_mystery_calculation(x,y)
% latex: result=\sum sqrt[9]{\frac{\left( \sqrt[3]{\frac{2x(2-y)}}}
%{\left( \sqrt[6]{\left( {sqrt[4]{(x^2y^2)+5}} \right)}^2 \right)}}
n=numel(x); % or numel(y)
top=zeros(n,1,'double');
bottom=zeros(n,1,'double');

for i=1:n
   top(i)=(2*x(i)*(2-y(i)))^(1/3);
end

for i=1:n
   bottom(i)=((((x(i)^2*y(i)^3)^(1/4)+5)^(1/6)));
end

for i=1:n
   value(i)=(top(i)/bottom(i))^(1/9);
end

% convert value array into a scalar
value=sum(value);
end


