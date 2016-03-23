% Center the image data at the origin, and scale it so the mean 
% squared distance between the origin and the data points is 2 pixels

function [newXi, T] = Normalised(Xi)
    Xi=Xi';
    c = mean(Xi(1:2,:)')';            % Centroid of finite points
    tempXi(1,:) = Xi(1,:)-c(1); % Shift origin to centroid.
    tempXi(2,:) = Xi(2,:)-c(2);
    
    dist = sqrt(tempXi(1,:).^2 + tempXi(2,:).^2);
    mean_dist = mean(dist(:));  % Ensure dist is a column vector for Octave 3.0.1
    
    scale = 2/mean_dist;
    
    T = [scale   0   -scale*c(1)
         0     scale -scale*c(2)
         0       0      1      ];
    
    newXi = T*Xi;