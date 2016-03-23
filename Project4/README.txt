To do Object Recognition:

Run: readImage.m

To train images and test image

If you need to add your own path, please change the path in readImage.m

%read train image from path

file_path =  '/Users/Serena/Documents/MATLAB/Object Recognition_Harris/groundtruth_GRAZ_02_900_images/';

img_path_list = dir(strcat(file_path,'*.jpg’));