%Please be gentle, don't chage the scale of threshold and the size of image
%Please be gentle, don't chage the scale of threshold and the size of image
%Please be gentle, don't chage the scale of threshold and the size of image

clc;
clear all;
close all;

%--read image---------------------------------------------------------------
source_1=imread('uttower_left.JPG');              
source1=rgb2gray(source_1);             %change to grayscale image
[r1,c1]=harris_function(source1);       %detect harris corner, return corrodinates
source_2=imread('uttower_right.JPG');
source2=rgb2gray(source_2);
[r2,c2]=harris_function(source2);

%--leftimage---------------------------------------------------------------
count=1;
%for every corner, extract 5*5 patches and form a 25*1 descriptor
for i = 1: size(r1)
    for j=1: size(c1)
        if i==j       %?????
            descriptor1=setDescriptor(source1,r1(i),c1(j));
            sDescriptor1(:,count)=descriptor1;
            count=count+1;
        end
    end
end

%--rightimage---------------------------------------------------------------
count=1;
%sDescriptor2=zeros(25,289);
for i = 1: size(r2)
    for j=1: size(c2)
        if i==j       %?????
            descriptor2=setDescriptor(source2,r2(i),c2(j));
            sDescriptor2(:,count)=descriptor2;
            count=count+1;
        end
    end
end
%--norm_corr---------------------------------------------------------------
%compute the normalized correlation by using relative formula
[norm_corr]=corr_norm(sDescriptor1,sDescriptor2);
for i=1:size(norm_corr,1);
    %match every feature point in left image and right image, return label
    top_norm(i)=find(max(norm_corr(i,:))==norm_corr(i,:));
end

%--------------------------------------------------------------------------
%Adaptively determining the number of samples
N=1e20;         %repeat times, set a infinity #
sample_count=0; 
while N>sample_count
%--pair 8 points-----------------------------------------------------------
  
for find_bestF=1:10             %get 10 Fs, them find the temporary best F

    %randomly get 8 point from 1 to 289. 
    norm1_8=randperm(289,8);        

for i=1:8
     %for every value in left image, get the mapping value
    norm2_8(i)=top_norm(norm1_8(i));    
end

for i=1:8
    U(i,1)=r1(norm1_8(i));      %get the corrodinates in oringnal image
    V(i,1)=c1(norm1_8(i));
end
for i=1:8
    U(i,2)=r2(norm2_8(i));
    V(i,2)=c2(norm2_8(i));
end

%Compute and get Fundamental Matrix
% x = (u, v, 1)',   x? = (u?, v?, 1)'
% xT*F*x'=0
M(:,1)=U(:,1).*U(:,2);  
M(:,2)=U(:,1).*V(:,2);
M(:,3)=U(:,1);
M(:,4)=V(:,1).*U(:,2);
M(:,5)=V(:,1).*V(:,2);
M(:,6)=V(:,1);
M(:,7)=U(:,2);
M(:,8)=V(:,2);

I=ones(8,1);
temp_F=-M\I;
temp_F(9)=1;
F(1,:)=temp_F(1:3);
F(2,:)=temp_F(4:6);
F(3,:)=temp_F(7:9);

set_bestF(:,:,find_bestF)=F;        %store F

%Xi_1 and Xi_2 are 3*N array
Xi_1(:,1)=U(:,1);                   %homogeneous corrodinates
Xi_1(:,2)=V(:,1);
Xi_1(:,3)=ones(8,1);
Xi_2(:,1)=U(:,2);
Xi_2(:,2)=V(:,2);
Xi_2(:,3)=ones(8,1);

norm_X1=Normalised(Xi_1);           %normalize points
norm_X2=Normalised(Xi_2);
Xi_1=norm_X1';
Xi_2=norm_X2';

%compute error (xT*F*x')^2
error=0;
for i=1:8
    a=Xi_1(i,:)*F*Xi_2(i,:)';
    a=a^2;
    error=error+a;
end
e(:,find_bestF)=error;      %store errors
end
%find best F matrix
for i=1:size(e);
    label_bestF=find(min(e)==e);
    bestF=set_bestF(:,:,label_bestF);
end
%--oringe x,y fit into F---------------------------------------------------
%for ALL feature points, build homogeneous corrodinates
oringe_X1(:,1)=r1;
oringe_X1(:,2)=c1;
oringe_X1(:,3)=ones(289,1);
for i = 1:289
    oringe_X2(i,1)=r2(top_norm(i));
    oringe_X2(i,2)=c2(top_norm(i));  
end
oringe_X2(:,3)=ones(289,1);

%normalize all points
[normXi_1,T1]=Normalised(oringe_X1);
[normXi_2,T2]=Normalised(oringe_X2);
oringe_X1=normXi_1';
oringe_X2=normXi_2';

%computer # of inliners
sum=0;
for i=1:289
    a=oringe_X1(i,:)*bestF*oringe_X2(i,:)';
    if abs(a^2)<e(label_bestF)
        sum=sum+1;
    end
end
e_=1-sum/289;   %outliner ratio
s=8;            %Initial number of points
p=0.99;         %probability for inlier 
N=log(1-p)/log(1-(1-e_)^s); %recompute N from e
sample_count=sample_count+1;
end

Final_F=bestF;      %get best F matrix

% Enforce constraint that fundamental matrix has rank 2 by performing
% a svd and then reconstructing with the two largest singular values.

[U,D,V] = svd(Final_F,0);
Final_F = U*diag([D(1,1) D(2,2) 0])*V';

 % Denormalise
Final_F = T2'*Final_F*T1;


    



