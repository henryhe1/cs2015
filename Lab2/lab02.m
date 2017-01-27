% A plot of the square root function
x = [0:0.1:4];
plot(x,sqrt(x));
title('square root');
xlabel('x');
ylabel('y');
print square_root.jpg -djpeg

% A plot of the exponential function
x = [-2:0.1:5];
plot(x,exp(x));
title('exponential function');
xlabel('x');
ylabel('y');
print exp.jpg -djpeg

% A plot of the natural logarithm function
x = [0.1:0.1:10];
plot(x, log(x));
title('natural logarithm');
xlabel('x');
ylabel('y');
print natural.jpg -djpeg