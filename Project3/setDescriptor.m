function [ a ] = setDescriptor( source,r,c )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%im=im2double(rgb2gray(source));
im=source;
a=zeros(25,1);
if(r>2&&c>2)
    a(1,1)=im(r-2,c-2);
else a(1,1)=0;
end
if(r>1&&c>2)    
    a(2,1)=im(r-1,c-2);
else a(2,1)=0;
end
if(c>2)      
    a(3,1)=im(r-0,c-2);
else a(3,1)=0;
end
if(r<683&&c>2)          %???????????????
    a(4,1)=im(r+1,c-2);
else a(4,1)=0;
end
if (r<682&&c>2)
    a(5,1)=im(r+2,c-2);
else a(5,1)=0;
end
if (r>2&&c>1)
    a(6,1)=im(r-2,c-1);
else a(6,1)=0;
end
if (r>1&&c>1)
    a(7,1)=im(r-1,c-1);
else a(7,1)=0;
end
if (c>1)
    a(8,1)=im(r-0,c-1);
else a(8,1)=0;
end
if (r<683&&c>1)
    a(9,1)=im(r+1,c-1);
else a(9,1)=0;
end
if (r<682&&c>1)
    a(10,1)=im(r+2,c-1);
else a(10,1)=0;
end
if (r>2)
    a(11,1)=im(r-2,c);
else a(11,1)=0;
end
if (r>1)
    a(12,1)=im(r-1,c);
else a(12,1)=0;
end
    a(13,1)=im(r-0,c);
if (r<683)
    a(14,1)=im(r+1,c);
else a(14,1)=0;
end
if (r<682)
    a(15,1)=im(r+2,c);
else a(15,1)=0;
end
if (r>2&&c<1024)
    a(16,1)=im(r-2,c+1);
else a(16,1)=0;
end
if (r>1&&c<1024)
    a(17,1)=im(r-1,c+1);
else a(17,1)=0;
end
if (c<1024)
    a(18,1)=im(r-0,c+1);
else a(18,1)=0;
end
if (r<683&&c<1024)
    a(19,1)=im(r+1,c+1);
else a(19,1)=0;
end
if (r<682&&c<1024)
    a(20,1)=im(r+2,c+1);
else a(20,1)=0;
end
if (r>2&&c<1023)
    a(21,1)=im(r-2,c+2);
else a(21,1)=0;
end
if (r>1&&c<1023)
    a(22,1)=im(r-1,c+2);
else a(22,1)=0;
end
if (c<1023)
    a(23,1)=im(r-0,c+2);
else a(23,1)=0;
end
if (r<683&&c<1023)
    a(24,1)=im(r+1,c+2);
else a(24,1)=0;
end
if (r<682&&c<1023)
    a(25,1)=im(r+2,c+2);
else a(25,1)=0;
end

    
end

