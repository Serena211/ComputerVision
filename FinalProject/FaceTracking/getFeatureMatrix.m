function res = getFeatureMatrix(imgs)
    res = zeros(size(imgs,1),size(imgs,2),size(imgs,3));     
    for i = 1:size(imgs,3)
        img = imgs(:,:,i);
        res(:,:,i) = cumsum(cumsum(double(img)),2);
    end
end