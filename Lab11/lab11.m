RGB1=imread('lena.jpg');
RGB2=imread('mando.jpg');
I1=rgb2gray(RGB1);
I2=rgb2gray(RGB2);
image_size=size(RGB1);

E1=edge(I1,'sobel');
figure
imshow(E1,[]);
title('Sobel default white edge map for lena image');
print sobel_white_edge_lena.jpg -djpeg
figure
imshow(~E1,[]);
title('Sobel default black edge map for lena image');
print sobel_black_edge_lena.jpg -djpeg

E2=edge(I1,'canny');
figure
imshow(E2,[]);
title('Canny default white edge map for lena image');
print canny_white_edge_lena.jpg -djpeg
figure
imshow(~E2,[]);
title('Canny default black edge map for lena image');
print canny_black_edge_lena.jpg -djpeg


R1=squeeze(RGB1(:,:,1));
G1=squeeze(RGB1(:,:,2));
B1=squeeze(RGB1(:,:,3));
R2=squeeze(RGB2(:,:,1));
G2=squeeze(RGB2(:,:,2));
B2=squeeze(RGB2(:,:,3));

% Sobel Colour edges for lena
sobelER1=edge(R1,'sobel');
sobelEG1=edge(G1,'sobel');
sobelEB1=edge(B1,'sobel');
 
sobel_colour1=zeros(image_size,'double');
sobel_colour2=zeros(image_size,'double');
sobel_colour1(:,:,1)=sobelER1*255;
sobel_colour1(:,:,2)=sobelEG1*255;
sobel_colour1(:,:,3)=sobelEB1*255;
figure
imshow(sobel_colour1);
title('Sobel colour edge map for lena image');
print sobel_colour_edge_lena.jpg -djpeg

sobel_colour2=sobel_colour1;
for i=1:size(sobel_colour1,1)
for j=1:size(sobel_colour1,2)
if(sobel_colour1(i,j,1)==255 & sobel_colour1(i,j,2)==255 & sobel_colour1(i,j,3)==255)
   sobel_colour2(i,j,1)=0;
   sobel_colour2(i,j,2)=0;
   sobel_colour2(i,j,3)=0;
end % if
if(sobel_colour1(i,j,1)==0 & sobel_colour1(i,j,2)==0 & sobel_colour1(i,j,3)==0)
   sobel_colour2(i,j,1)=255;
   sobel_colour2(i,j,2)=255;
   sobel_colour2(i,j,3)=255;
end % if  
end % for j
end % for i
figure
imshow(sobel_colour2);
title('Sobel flipped colour edge map for lena image');
print sobel_flipped_colour_edge_lena.jpg -djpeg

% Canny colour edges for lena
cannyER1=edge(R1,'canny');
cannyEG1=edge(G1,'canny');
cannyEB1=edge(B1,'canny');
 
canny_colour1=zeros(image_size,'double');
canny_colour2=zeros(image_size,'double');
canny_colour1(:,:,1)=cannyER1*255;
canny_colour1(:,:,2)=cannyEG1*255;
canny_colour1(:,:,3)=cannyEB1*255;
figure
imshow(canny_colour1);
title('Canny colour edge map for lena image');
print canny_colour_edge_lena.jpg -djpeg

canny_colour2=canny_colour1;
for i=1:size(canny_colour1,1)
for j=1:size(canny_colour1,2)
if(canny_colour1(i,j,1)==255 & canny_colour1(i,j,2)==255 & canny_colour1(i,j,3)==255)
   canny_colour2(i,j,1)=0;
   canny_colour2(i,j,2)=0;
   canny_colour2(i,j,3)=0;
end % if
if(canny_colour1(i,j,1)==0 & canny_colour1(i,j,2)==0 & canny_colour1(i,j,3)==0)
   canny_colour2(i,j,1)=255;
   canny_colour2(i,j,2)=255;
   canny_colour2(i,j,3)=255;
end % if  
end % for j
end % for i
figure
imshow(canny_colour2);
title('Canny flipped colour edge map for lena image');
print canny_flipped_colour_edge_lena.jpg -djpeg

