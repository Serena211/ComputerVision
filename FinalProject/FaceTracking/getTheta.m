function [ theta, error ] = getTheta( w, y, s, f )
    %Decide the theta
%     theta1=0;
%     theta2=5;
%     iter=1000;
%     while iter>0
%         sum1 = 0;
%         sum2 = 0;
%         for i=1:size(w,1)
%             z=w(i)*y(i)*sign(s*f(i)-theta1);
%             sum1=sum1+z;
%             z=w(i)*y(i)*sign(s*f(i)-theta2);
%             sum2=sum2+z;
%         end
%         error=sum1-sum2;
%         if error==0
%             break
%         end
%         if (sum2~=sum1)
%             if (sum2>sum1)
%                 theta1=theta2;
%                 theta2=theta2+5;
%             else
%                 theta2=(theta2+theta1)/2;
%             end
%         end
% 
% 
%     iter=iter-1;
%     end
%     theta=theta2;
    mat = [f w y];
    mat = sortrows(mat, 1);
    totalFaceWeight = 0;
    totalNonfaceWeight = 0;
    for i =1:size(mat,1)
        if mat(i,3) == 1
            totalFaceWeight = totalFaceWeight + mat(i,2);
        else
            totalNonfaceWeight = totalNonfaceWeight + mat(i,2);
        end
    end
    for i = 1:size(mat,1)
        t1(i) = totalFaceWeight;
        t0(i) = totalNonfaceWeight;
        s1(i) = 0;
        s0(i) = 0;
        for j = 1:i-1
            if mat(j,3) == 1
                s1(i) = s1(i) + mat(j,2);
            else
                s0(i) = s0(i) + mat(j,2);
            end
        end
        r(i) = min((s1(i) + (t0(i) - s0(i))), (s0(i) + (t1(i) - s1(i))));
    end
    theta = min(r);
    error = 0;
end