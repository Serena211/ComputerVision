function res = getPictureData(src, dir)
    for i = 1:length(src)
        filename = strcat(dir, src(i).name);
        I = imread(filename);
        I = im2double(I);
        I = imresize(I, 0.5);
        res(:,:,i) = I(:,:);
    end
end