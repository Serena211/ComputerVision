clc;
clear all;
close all;

% read the images from file;
image1 = imread('audi1.jpg');
image2 = imread('audi2.jpg');

%%Filtering and Hybrid Image construction
%Get Low-pass filtered image
cutoff_low = 5;     %set the size of cut off frequencies;
%get filter
low_pass_filter = fspecial('Gaussian', cutoff_low*4+1, cutoff_low);  
%get final low-pass picture
low_frequencies = imfilter(image1, low_pass_filter, 'replicate'); 

cutoff_high =9;
high_pass_filter = fspecial('Gaussian', cutoff_high*4+1, cutoff_high);
%High_pass(I) = I - Low_pass(I)
high_frequencies = image2 - imfilter(image2, high_pass_filter, 'replicate'); 

%Combine low_pass and high_pass images to get hybrid image;
hybridImage = low_frequencies + high_frequencies;

%show picture on screen
figure; imshow(hybridImage); title('Hybrid_Images');

%Output image
filename = 'hybirdImage';
print('-djpeg', filename);

