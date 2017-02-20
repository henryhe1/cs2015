function ass2_example()
x=rand(1000000,1,'double');

start=tic;
sigma=std(x);
finish0=toc(start);

start=tic;
serial_sigma=serialized_std(x);
finish1=toc(start);

start=tic;
vector_sigma=vectorized_std(x);
finish2=toc(start);

fprintf('MatLab std: %f in time %f\n',sigma,finish0);
fprintf('Serialized std: %f in time %f\n',serial_sigma,finish1);
fprintf('Vectorized std: %f in time %f\n',vector_sigma,finish2);
fprintf('\n');
fprintf('Speedup of MatLab std over serialized: %f\n',finish1/finish0);
fprintf('Speedup of vectorized over MatLab std: %f\n',finish0/finish2);
fprintf('Speedup of vectorized over serialized: %f\n',finish1/finish2);
end

function value=vectorized_std(x)
value=sqrt(sum((x-mean(x)).^2)/(numel(x)-1));
end

function value=serialized_std(x)
n=numel(x);
x_ave=mean(x);
value=0;
for i=1:n
    value=value+(x(i)-x_ave)^2;
end % i
value=sqrt(value/(n-1));
end

