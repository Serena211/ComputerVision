function [x, y, w, h] = ycrcb(I)
I=im2double(I);

a=size(I,1);
b=size(I,2);
CC=zeros(a,b,2);

for i=1:a
    for j=1:b
        CC(i,j,1)=-37.797*I(i,j,1)-74.203*I(i,j,2)+112*I(i,j,3)+128;
        CC(i,j,2)=112*I(i,j,1)-93.786*I(i,j,2)-18.214*I(i,j,3)+128;
    end
end

P=zeros(a,b);
for i=1:a
    for j=1:b
        if CC(i,j,1)>=100 && CC(i,j,1)<=127 && CC(i,j,2)>=137 && CC(i,j,1)<=170
            P(i,j)=1;
        end
    end
end
% 
% figure;
% imshow(I);


% Close calculation, connect near areas
se=strel('square',20);
P=imclose(P,se);

% fill in holes
P = imfill(P,'holes');

% Open calculation, shrink white areas
P=imopen(P,se);

% elimate blobs
P= bwareaopen(P, 250);



L = bwlabel(P);

% Calculate region properties for connected components
s = regionprops(L);

area = cat(1, s.Area);
Area=area;
bound=cat(1,s.BoundingBox);

if length(area)<4
    loop=length(area);
else
    loop=4;
end
if loop == 0
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    return;
end

Gray=rgb2gray(I); 
for i=1:loop
    maybe1(i)=find(max(area)==area);
    area(maybe1(i))=0;
    
%     RR=imcrop(Gray,bound(maybe1(i),:));
%     figure;
%     imshow(RR);
end


t=1;
for i=1:length(maybe1)
    prop=bound(maybe1(i),4)/bound(maybe1(i),3);
    if prop>0.8 && prop<2 && Area(maybe1(i))>3000
        maybe(t)=maybe1(i);
%         RR=imcrop(Gray,bound(maybe(t),:));
%         figure;
%         imshow(RR);      
    
        t=t+1;
    end
end

if t == 1
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    return;
end

count=0;
for i=1:length(maybe)
    Crop=imcrop(Gray,bound(maybe(i),:));
    row=size(Crop,1);
    col=size(Crop,2);
    edge=max(row,col);
    
    Imaybe=zeros(edge,edge);
    
    if edge==row
        Imaybe(:,round((edge-col)/2):round((edge-col)/2+col-1))=Crop;
    else
        Imaybe(round((edge-row)/2):round((edge-row)/2+row-1),:)=Crop;
    end
   
    for j=3
        patch=imcrop(Imaybe,[0.05*j*edge 0 (1-0.1*j)*edge (1-0.1*j)*edge]);
        patch=imresize(patch,[12,12]); % change to 12x12 pixels
%         figure;
%         imshow(patch);
        isTrue = detectFace(patch);
        if isTrue==1
            count=count+1;
            aaa=bound(maybe(i),:);
            x(count)=aaa(1)-(edge-col)/2+0.05*j*edge;
            y(count)=aaa(2);
            h(count)=(1-0.1*j)*edge;
            w(count)=h(count);
        end
        
%         figure;
%         imshow(patch);  
    end  
end

if ~exist('x', 'var')
    x = 0;
    y = 0;
    h = 0;
    w = 0;
end
end




