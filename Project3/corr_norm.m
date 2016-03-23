function [ norm_corr ] = corr_norm( sDescriptor1,sDescriptor2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x=sDescriptor1;
y=sDescriptor2;
corr_xy=zeros(289,316);
norm_den=zeros(289,316);
norm_corr=zeros(289,316);
for i=1:289
    for j=1:316
        corr_xy(i,j)=x(:,i)'*y(:,j);
        norm_den(i,j)=norm(x(:,i),2)*norm(y(:,j),2);
        norm_corr(i,j)=corr_xy(i,j)/norm_den(i,j);            
    end
end


