% The purpose of this project is using Matlab to deal with images. 
[colorImage,map] = imread('VV150.jpg');%Load the color image into a 3D array.
R=colorImage(:,:,1);%save one of the three color components from the input image;store the first component of 3D array
G=colorImage(:,:,2);
B=colorImage(:,:,3);
Rcolor=zeros(size(colorImage)); %returns an n-by-n matrix of zeros, this matrix has the same size of original image
Gcolor=zeros(size(colorImage));
Bcolor=zeros(size(colorImage));
Rcolor=cat(3,R,zeros(size(G)),zeros(size(B)));%concatenates all the input arrays;assign one color and keep the other two components to be zero. 
Gcolor=cat(3,zeros(size(R)),G,zeros(size(B)));
Bcolor=cat(3,zeros(size(R)),zeros(size(G)),B);
RGBcolor=cat(3,R,G,B);
figure; imshow(Rcolor); title('Red image')%Display the color image with Red component in a figure
figure; imshow(Gcolor); title('Green image')%Display the color image with Green component in a figure
figure; imshow(Bcolor); title('Blue image')%Display the color image with Blue component in a figure
figure; imshow(RGBcolor,map); title('Original image')
