function weight = normalizeWeight(src)
    total = 0;
    for i = 1:size(src, 1)
        total = total + src(i);
    end
    weight = src / total;
end