function res = getF(kind, FeatureMatrix, row2, row1, col2, col1)
    switch kind
        case 1 % up/down
            mid = (row2 + row1) / 2;
            mid = uint8(mid);
            down = getIntegralImage(FeatureMatrix, row2, mid, col2, col1);
            up = getIntegralImage(FeatureMatrix, mid, row1, col2, col1);
            res = abs(down - up);
        case 2 % left/right
            mid = (col2 + col1) / 2;
            mid = uint8(mid);
            left = getIntegralImage(FeatureMatrix, row2, row1, mid, col1);
            right = getIntegralImage(FeatureMatrix, row2, row1, col2, mid);
            res = abs(right - left);
        case 3 % middle
            midLeft = (2 * col2 + col1) / 3;
            midRight = (col2 + 2 * col1) / 3;
            midLeft = uint8(midLeft);
            midRight = uint8(midRight);
            left = getIntegralImage(FeatureMatrix, row2, row1, midLeft, col1);
            right = getIntegralImage(FeatureMatrix, row2, row1, col2, midRight);
            middle = getIntegralImage(FeatureMatrix, row2, row1, midRight, midLeft);
            res = abs(left + right - middle);
        case 4 % diagonal
            midRow = (row2 + row1) / 2;
            midCol = (col2 + col1) / 2;
            midRow = uint8(midRow);
            midCol = uint8(midCol);
            upLeft = getIntegralImage(FeatureMatrix, midRow, row1, midCol, col1);
            upRight = getIntegralImage(FeatureMatrix, midRow, row1, col2, midCol);
            downLeft = getIntegralImage(FeatureMatrix, row2, midRow, midCol, col1);
            downRight = getIntegralImage(FeatureMatrix, row2, midRow, col2, midCol);
            res = abs(upLeft + downRight - upRight - downLeft);
    end
end