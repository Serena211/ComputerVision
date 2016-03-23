clc;
clear all;
close all;

threshold=1000;             %set threshold to detect potential corners
dy=fspecial('sobel');                           % Y Derivative masks
dx=dy';                                         % X Derivative masks
sigma=2;
gaussian=fspecial('gaussian',[7,7],sigma);      %Gaussian filter

source=imread('ATL_Goliath4.jpg');              %read image

im=source(:,:,3);                               

Ix=conv2(im, dx, 'same');                       % Image derivatives
%imshow(Ix);
Iy=conv2(im, dy, 'same');
%imshow(Iy);
Ix2=conv2(Ix.*Ix, gaussian, 'same');    % Smoothed squared image derivatives
%imshow(Ix2)
Iy2=conv2(Iy.*Iy, gaussian, 'same');
%imshow(Iy2)
Ixy=conv2(Ix.*Iy, gaussian, 'same');
%imshow(Ixy)

Harris= (Ix2.*Iy2-Ixy.*Ixy)./(Ix2+Iy2+eps); % Harris corner measure

radius=1;
size=2*radius+1;
% a grey scale morphological dilation
mx=ordfilt2(Harris, size.^2, ones(size));  

%finding points in the corner strength image that match the dilated image
%and are also greater than the threshold
Harris = (Harris == mx) & (Harris > threshold); 

[r,c]=find(Harris);   %row & colum coordinates of corner points.
figure, image(source), axis image, colormap(gray), hold on,
plot(c,r,'ys');       %display
