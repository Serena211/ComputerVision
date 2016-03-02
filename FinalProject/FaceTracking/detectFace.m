function res = detectFace(img)
    img = im2double(img);
    featureMatrix = cumsum(cumsum(double(img)),2);
    bestHParam = dlmread('bestHParam.txt',' '); % [kind row2 row1 col2 col1 theta s minError]
    bestAlpha = dlmread('bestAlpha.txt', ' '); % alpha
    range = size(bestHParam, 1);
    totalH = 0;
    totalAlpha = 0;
    for i = 1:range
        kind = bestHParam(i,1);
        row2 = bestHParam(i,2);
        row1 = bestHParam(i,3);
        col2 = bestHParam(i,4);
        col1 = bestHParam(i,5);
        theta = bestHParam(i,6);
        s = bestHParam(i,7);
        minError = bestHParam(i,8);
        alpha = bestAlpha(i);
        %total = total + filterImg(img, kind, row2, row1, col2, col1, theta, s, alpha);
        f = getF(kind, featureMatrix, row2, row1, col2, col1);
        totalH = totalH + alpha * getH(f, theta, s);
        totalAlpha = totalAlpha + alpha;
    end
    if (totalH >= 0.5 * totalAlpha)
        res = 1;
    else
        res = 0;
    end
end