function [ catDescriptor ] = getDescriptorSet( img_num,file_path, img_path_list )
% This function reads train images by using file path, and 
%generate a set of descriptors of all input images. 
%img_num is the number of inpute train images. 
%file_path is a path of fetching train images.
%img_path_list for read train images

count=1;    %count for combining descriptors.

%read images
if img_num > 0 % condintions for read images
    for j = 1:img_num 
        image_name = img_path_list(j).name;% image name
        image =  imread(strcat(file_path,image_name));
        image = im2double(image);
        
%Image processing
        %Harris corner detection
        Harris = corner(image,'Harris','SensitivityFactor',0.001);
        
        %for every corner, extract 5*5 patches and form a 25*1 descriptor
        for i = 1: size(Harris(:,1))
            for j=1: size(Harris(:,2))
                if i==j       %?????
                    descriptor=setDescriptor(image,Harris(i,2),Harris(j,1));
                    %store every descriptor in a new matrix
                    catDescriptor(:,count)=descriptor;
                    count=count+1;
                end
            end
            
        end
    end
    catDescriptor = catDescriptor'; %get the final descriptor set
end


end

