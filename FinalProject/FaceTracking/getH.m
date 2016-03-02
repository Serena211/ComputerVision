function res = getH(f, theta, s)
    for i = 1:size(f,1)
        if (s * f(i,1) > s * theta)
            res(i) = 1; % face
        else
            res(i) = 0; % nonface
        end
    end
end