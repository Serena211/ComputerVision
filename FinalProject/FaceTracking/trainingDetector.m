function [bestHParam, bestAlpha] = trainingDetector()
    faceSrc = dir('/Users/wyf920621/Documents/MATLAB/faceTrainingData/faces/*.gif');
    faceDir = '/Users/wyf920621/Documents/MATLAB/faceTrainingData/faces/';
    nonfaceSrc = dir('/Users/wyf920621/Documents/MATLAB/faceTrainingData/nonfaces/*.gif');
    nonfaceDir = '/Users/wyf920621/Documents/MATLAB/faceTrainingData/nonfaces/';
    faceImgs = getPictureData(faceSrc, faceDir);
    nonfaceImgs = getPictureData(nonfaceSrc, nonfaceDir);
    %faceImgs = im2double(faceImgs);
    %nonfaceImgs = im2double(nonfaceImgs);
    faceLabels = ones(size(faceImgs, 3), 1, 'double');
    %nonfaceLabels = -ones(size(nonfaceImgs, 3), 1, 'double');
    nonfaceLabels = zeros(size(nonfaceImgs, 3), 1, 'double');
    faceWeight = ones(size(faceImgs, 3), 1) / (2 * size(faceImgs, 3));
    nonfaceWeight = ones(size(nonfaceImgs, 3), 1) / (2 * size(nonfaceImgs, 3));
    imgSize = size(faceImgs,1);
    imgs = cat(3, faceImgs, nonfaceImgs);
    labels = cat(1, faceLabels, nonfaceLabels);
    clear faceSrc;
    clear faceDir;
    clear nonfaceSrc;
    clear nonfaceDir;
    clear faceImgs;
    clear faceLabels;
    clear nonfaceImgs;
    clear nonfaceLabels;
    totalNumber = size(imgs, 3);
    %weight = ones(totalNumber,1) / totalNumber;
    weight = [faceWeight; nonfaceWeight];
    clear faceWeight;
    clear nonfaceWeight;
    s = 1; % initialize polarity
    countH = 1;
    maxIter = 3;
    while maxIter > 0
       minError = 2; % max error is 1
       weight = normalizeWeight(weight);
       featureMatrix = getFeatureMatrix(imgs);
       for kind = 1:4 % Differen kind, see getF()
           for row1 = 1:imgSize
               for row2 = 1:imgSize
                   for col1 = 1:imgSize
                       for col2 = 1:imgSize
                           if (row2 > row1) && (col2 > col1)
                               for count = 1:size(imgs,3) % number of imgs
                                   imgFeatureMatrix = featureMatrix(:,:,count);
                                   f(count,1) = getF(kind, imgFeatureMatrix, row2, row1, col2, col1);
                               end
                               [theta, thetaE] = getTheta(weight, labels, s, f);
                               [maxIter kind row1 row2]
                               [error, errorList] = getError(weight, f, labels, theta, s);
                               if error < minError
                                   'new classifier'
                                   minError = error;
                                   minErrorList = errorList;
                                   bestHParam(countH,:) = [kind row2 row1 col2 col1 theta s minError];
                               end
                           end
                       end
                   end
               end
           end
       end
       % Get alpha and beta
       beta = minError / (1 - minError);
       alpha = -log(beta);
       bestAlpha(countH) = alpha;
       % Update weight
       for i = 1:size(weight,1)
           weight(i) = weight(i) * (beta ^ (1 - minErrorList(i)));
       end
       bestHParam(countH,:)
       bestAlpha(countH)
       % loop
       countH = countH + 1;
       if minError < 0.2
           break;
       end
       maxIter = maxIter - 1;
    end
    dlmwrite('bestHParam.txt', bestHParam, 'delimiter', ' ');
    dlmwrite('bestAlpha.txt', bestAlpha, 'delimiter', ' ');
end