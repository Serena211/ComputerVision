function res = getIntegralImage(FeatureMatrix, row1, row2, col1, col2)
    if row1 > row2
        bRow = row1;
        sRow = row2;
    else
        bRow = row2;
        sRow = row1;
    end
    if col1 > col2
        bCol = col1;
        sCol = col2;
    else
        bCol = col2;
        sCol = col1;
    end
    A = FeatureMatrix(bRow, bCol);
    B = FeatureMatrix(bRow, sCol);
    C = FeatureMatrix(sRow, bCol);
    D = FeatureMatrix(sRow, sCol);
    res = A - B - C + D;
end