function [ label ] = getMin( descriptor, K)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

for k=1:size(K,1)
    
    temp(k)=norm(descriptor'-K(k,:));
    
end

label=find(min(temp)==temp);

end

