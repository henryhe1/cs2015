%x and y are symbolic variables
syms x y

% differentiation
fprintf('\nDifferentiation\n');

f = exp(x^2 + y^2);

%differentiate with respect to x
fx = diff(f,x);

%differentiate with respect to y
fy = diff(f,y);

%differentiate with respect to x and then to y
fxy = diff(diff(f,x),y);
%differentiate with respect to y and then to x
fyx = diff(diff(f,y),x);

fprintf('Derivatives evaluated when x=2 and y=3\n');
x = 2; y = 3;
fprintf('fx=');
eval(diff(f,x))
fprintf('fy=');
eval(diff(f,y))
fprintf('fxy=');
eval(diff(diff(f,y),x))
fprintf('fyx=');
eval(diff(diff(f,x), y))

fprintf('\nIntegration\n');

% integration
syms x y

xmin = -2; 
xmax = 2;
ymin = -3;
ymax = 3;

f = exp(x^2 + y^2);
Fx = int(f,x);
Fy = int(f,y);
Fyx = int(int(f,y),x);


fprintf('Fx=');
eval(int(f, x, xmin, xmax))
fprintf('Fy=');
eval(int(f, y, ymin, ymax))
fprintf('Fyx=');
eval(int(int(f, y, ymin, ymax), x, xmin, xmax))


[X,Y] = meshgrid(xmin:0.1:xmax, ymin:0.1:ymax);
Z = exp(X.^2 + Y.^2);
surf(X,Y,Z);
title('f=exp(x^2+y^2)');
print 2Dfct.jpg -djpeg

fun=@(X,Y) exp(X.^2 + Y.^2);
fprintf('The value of the integral using integral2: %f\n',...
    integral2(fun, xmin, xmax, ymin, ymax));


fprintf('\nLinear Algebra\n');

syms a b c d e f g h i 
syms b1 b2 b3 
syms x1 x2 x3

A = [a b c; 
    d e f; 
    g h i];
B = [b1;b2;b3];
x = [x1;x2;x3];

AI = inv(A)

x = AI * B
x = A\B

fprintf('\nPolynomials\n');

syms x
p = (x^5) - (2*x^4) - (28*x^3) + (38*x^2) + (171*x) - 180
solve(p,x)
eval(solve(p,x))

syms x
p = (x^4) + (29*x^2) + 100
solve(p,x)
eval(solve(p,x))
