clc;
clear all;
close all;
tic;
%read train image from path
file_path =  '/Users/Serena/Documents/MATLAB/Object Recognition_Harris/groundtruth_GRAZ_02_900_images/';% ???????
img_path_list = dir(strcat(file_path,'*.jpg'));%?????????jpg?????
img_num = length(img_path_list);%???????

%get a set of descriptor of all train images
 catDescriptor  = getDescriptorSet( img_num,file_path, img_path_list );

 %Run K-means clustering on all training features to learn the dictionary
[idx,K] = kmeans( catDescriptor, 150);

%get the dictionary
finalLabel = getLabel(K, img_num,file_path, img_path_list );

%set class label
bike = ones(200,1);
car = 2 * ones(200,1);
people = 3 * ones(200,1);
classifier=[bike; car; people];
%clssify SVM method
model=svmtrain(classifier,finalLabel);

%test
file_path_test =  '/Users/Serena/Documents/MATLAB/Object Recognition_Harris/test/';
img_path_list_test = dir(strcat(file_path_test,'*.jpg'));
img_num_test = length(img_path_list_test);

finalLabel_test = getLabel(K, img_num_test,file_path_test, img_path_list_test );

bike_label=finalLabel_test(1:100,:);
bike_test = ones(100,1);
car_label=finalLabel_test(101:200,:);
car_test = 2 * ones(100,1);
people_label=finalLabel_test(201:300,:);
people_test = 3 * ones(100,1);

%svm predicate
[bike_predicted_label, bike_accuracy, bike_decision_value]=svmpredict(bike_test,bike_label,model);
[car_predicted_label, car_accuracy, car_decision_value]=svmpredict(car_test,car_label,model);
[people_predicted_label, people_accuracy, people_decision_value]=svmpredict(people_test,people_label,model);

toc;