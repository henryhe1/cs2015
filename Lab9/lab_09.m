close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataname={'dataset1','dataset2','dataset3'};

for I=1:3
load(dataname{I});
xcoords=0:0.1:10;

% Remember: x^1 is x and x^0 is 1
% order 1 fit
A=[]; B=[];
for i=1:numel(x)
A=[A; x(i)^1 x(i)^0]
B=[B; y(i)]
end
LSy1=A\B
ycoords1=LSy1(1).*xcoords+LSy1(2)

% order 2 fit
A=[]; B=[];
for i=1:numel(x)
A=[A; x(i)^2 x(i)^1 x(i)^0]
B=[B; y(i)]
end
LSy2=A\B
ycoords2=LSy2(1).*xcoords.^2+LSy2(2).*xcoords+LSy2(3); 

% order 3 fit
A=[]; B=[];
for i=1:numel(x)
A=[A; x(i)^3 x(i)^2 x(i)^1 x(i)^0]
B=[B; y(i)]
end
LSy2=A\B
ycoords3=LSy2(1).*xcoords.^3+LSy2(2).*xcoords.^2+LSy2(3).*xcoords+LSy2(4); 

% order 4 fit
A=[]; B=[];
for i=1:numel(x)
A=[A; x(i)^4 x(i)^3 x(i)^2 x(i)^1 x(i)^0]
B=[B; y(i)]
end
LSy2=A\B
ycoords4=LSy2(1).*xcoords.^4+LSy2(2).*xcoords.^3+LSy2(3).*xcoords.^2+LSy2(4).*xcoords + LSy2(5); 

% order 5 fit
A=[]; B=[];
for i=1:numel(x)
A=[A; x(i)^5 x(i)^4 x(i)^3 x(i)^2 x(i)^1 x(i)^0]
B=[B; y(i)]
end
LSy2=A\B
ycoords5=LSy2(1).*xcoords.^5+LSy2(2).*xcoords.^4+LSy2(3).*xcoords.^3+LSy2(4).*xcoords.^2 + LSy2(5).*xcoords + LSy2(6); 

figure
plot(x,y,'k*');
hold on
plot(xcoords,ycoords1,'r-');
hold on
plot(xcoords,ycoords2,'g-');
hold on
plot(xcoords,ycoords3,'b-');
hold on
plot(xcoords,ycoords4,'y-');
hold on
plot(xcoords,ycoords5,'m-');
hold off
legend('Original Data','1st Order LS Fit','2nd Order LS Fit', '3rd Order LS Fit', '4th Order LS Fit', '5th Order LS Fit');
title(['\fontsize{18} Least Squares Fit for ' dataname{I}]);
filename=['LSfit_' dataname{I} '_order_1_2_3_4_5.jpg']; 
print(filename,'-djpeg');

figure
plot(x,y,'k*');
hold on
p1=polyfit(x,y,1);
plot(xcoords,polyval(p1,xcoords),'r-');
hold on
p2=polyfit(x,y,2);
plot(xcoords,polyval(p2,xcoords),'g-');
hold on
p3=polyfit(x,y,3);
plot(xcoords,polyval(p3,xcoords),'b-');
hold on
p4=polyfit(x,y,4);
plot(xcoords,polyval(p4,xcoords),'y-');
hold on
p5=polyfit(x,y,5);
plot(xcoords,polyval(p5,xcoords),'m-');
hold off
legend('Original Data','1st Order Polyfit','2nd Order Polyfit', '3rd Order Polyfit', '4th Order Polyfit', '5th Order Polyfit');
title(['\fontsize{18} Polyfit for ' dataname{I}]);
filename=['Polyfit_' dataname{I} '_order_1_2_3_4_5.jpg']; 
print(filename,'-djpeg');

end % I