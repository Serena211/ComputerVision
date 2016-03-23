
function [ finalLabel ] = getLabel( K, img_num,file_path, img_path_list )
%This function read images and classify them, then output the label
%for every train or test images
    % K is a matrix of clustring centres. 
    % size(K,1)is the number of centers, 
    % size(K,2)is the length of descriptor.
    % img_num is the number of inpute images. 
    % file_path is a path of fetching images.
    % img_path_list for read test images


count=1;     %count for combining labels.
if img_num > 0 
    for j = 1:img_num 
        image_name = img_path_list(j).name;
        image =  imread(strcat(file_path,image_name));
        image = im2double(image);
        Harris = corner(image,'Harris','SensitivityFactor',0.001);
        
        for i = 1: size(Harris(:,1))
            for j=1: size(Harris(:,2))
                if i==j       
                    descriptor=setDescriptor(image,Harris(i,2),Harris(j,1));
                    tempLabel= getMin( descriptor, K);
                    label(i)=tempLabel;
                end
            end
        end
        %get every images label, then combine them
        A=zeros(1,500);
        for i=1:size(label,2)
            value=label(1,i);
            A(1,value)=A(1,value)+1;
        end
        finalLabel(count,:)=A;
        count=count+1;
        clear label;
    end
   
end




end

