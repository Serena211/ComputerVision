function [res, e] = getError(weight, f, y, theta, s) % res from 0 - 2
    H = getH(f, theta, s);
    res = 0;
    for i = 1:size(weight,1)
        if H(i) == y(i)
            e(i) = 0;
        else
            e(i) = 1;
        end
        res = res + weight(i) * e(i);
    end
end