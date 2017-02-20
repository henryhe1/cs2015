function g_fcts(num_x)
num_x=str2num(num_x)

x=rand(num_x,1,'double');
y=rand(num_x,1,'double');

start=tic;
g1=g1_fct(x,y);
finish1=toc(start)

start=tic;
g2=g2_fct(x,y);
finish2=toc(start);

fprintf('g1_fct=%20.10f serial time=%f\n',g1_fct(x,y),finish1);
fprintf('g2_fct=%20.10f vector time=%f\n',g2_fct(x,y),finish2);
end

function value=g1_fct(x,y)
val1=0;
val2=0;
for i=1:numel(x)
   val1=val1+x(i)^2;
   val2=val2+y(i)^2;
end
top=(sum(val1)-sum(val2))^(1/3);

val1=0;
val2=0;
for i=1:numel(x)
   val1=val1+(x(i)*y(i))^(1/6);
   val2=val2+(x(i)-y(i))^(1/4);
end
bottom=sum(val1)+sum(val2);

value=top/bottom;
end

function value=g2_fct(x,y)
top=(sum(x.^2)-sum(y.^2))^(1/3);
bottom=(sum((x.*y).^(1/6))+sum((x-y).^(1/4)));
value=top/bottom;
end
