function res = drawYellow(src, col, row)
    src(row, col, 1) = 255;
    src(row, col, 2) = 255;
    src(row, col, 3) = 0;
    res = src;
end