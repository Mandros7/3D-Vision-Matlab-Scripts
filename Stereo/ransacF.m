function [ F,errores ] = ransacF(x1,x2,p,w,th)
%RANSACF Summary of this function goes here
%   Detailed explanation goes here

%w: nivel de confianza
%p: porcentaje de inliers en el modelo
%th: umbral de inliers
k = log10(1-w)/log10(1-p^8);
error = -1;
F = [];
errores = [];
for i = 1:round(k)
    idx = randperm(length(x1));
    x1 = x1(:,idx);
    x2 = x2(:,idx);
    F_est = eightpoints(x1(:,1:8),x2(:,1:8));
    
    ind_inliers = [];
    
    %d = sqrt((Fp1(1)-Fp2(1)).^2+(Fp1(2)-Fp2(2)).^2+(Fp1(3)-Fp2(3)).^2)
 
    for z=1:length(x1)
        d = x2(:,z)'*F_est*x1(:,z);
        if d<th
            ind_inliers = [ind_inliers z];
        end
    end
    
    inliers1 = x1(:,ind_inliers);
    inliers2 = x2(:,ind_inliers);
    
    modF = eightpoints(inliers1,inliers2);
    
    e = (1/length(inliers1))*(sum(sum(inliers2' * modF * inliers1)).^2);
     
    errores = [errores e];
    if (error < 0 || e<error)
        error = e;
        F = modF;
    end
end
end

