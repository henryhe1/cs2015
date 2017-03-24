close all

for i=1:5
   
    figure
    dataname = strcat('lab10dataset', num2str(i), '.mat');
   load(dataname);
   
   x = double(x);
   y = double(y);
   
   scatter(x,y, '*')
   filetitle = strcat('lab10dataset', num2str(i));
    
   avgx = mean(x);
   avgy = mean(y);
   stdx = std(x);
   stdy = std(y);
   skewx = skewness(x);
   skewy = skewness(y);
   kurx = kurtosis(x);
   kury = kurtosis(y);
   
%    xmin = min(x);
%    xmax = max(x);
%    ymin = min(y);
%    ymax = max(y);

   xmin = 0.05;
   xmax = 0.7;
   ymin = 0.05;
   ymax = 0.95;

   text(xmin, ymax, filetitle, 'Color', 'g', 'FontSize', 15, 'Units', 'normalized');
   text(xmin + 0.05, ymax - 0.07, strcat('x mean=', num2str(avgx)), 'Color', 'r', 'Units', 'normalized', 'FontSize', 13);
   text(xmin + 0.05, ymax - 0.10, strcat('x std=', num2str(stdx)), 'Color', 'r', 'Units', 'normalized', 'FontSize', 13);
   text(xmin + 0.05, ymax - 0.13, strcat('x skewness=', num2str(skewx)), 'Color', 'r', 'Units', 'normalized', 'FontSize', 13);
   text(xmin + 0.05, ymax - 0.16, strcat('x kurtosis=', num2str(kurx)), 'Color', 'r', 'Units', 'normalized', 'FontSize', 13);

   text(xmax - 0.05, ymin + 0.16, strcat('y mean=', num2str(avgy)), 'Color', 'b', 'Units', 'normalized', 'FontSize', 13);
   text(xmax - 0.05, ymin + 0.13, strcat('y std=', num2str(stdy)), 'Color', 'b', 'Units', 'normalized', 'FontSize', 13);
   text(xmax - 0.05, ymin +  0.10, strcat('y skewness=', num2str(skewy)), 'Color', 'b', 'Units', 'normalized', 'FontSize', 13);
   text(xmax - 0.05, ymin + 0.07, strcat('y kurtosis=', num2str(kury)), 'Color', 'b', 'Units', 'normalized', 'FontSize', 13);

   print(strcat(filetitle, 'main'), '-djpeg')
%    
%    hist(x,11)
%    title(['x distribution for ', '\color{blue}', filetitle])
%    print(strcat(filetitle, 'xhist'), '-djpeg')
%    hist(y,11)
%    title(['y distribution for ', '\color{blue}', filetitle])
%    print(strcat(filetitle, 'yhist'), '-djpeg')
%    
   
    
end