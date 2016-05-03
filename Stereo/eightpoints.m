function [ F ] = eightpoints(x1,x2)
    s1 = length(x1); 

    x1=[x1(1,:)' x1(2,:)'];    
    x2=[x2(1,:)' x2(2,:)'];  

    A=[x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) ... 
        x1(:,1).*x2(:,2) x1(:,2).*x2(:,2) x2(:,2) ... 
        x1(:,1) x1(:,2), ones(s1,1)];  

    % Get F matrix  
    [U D V] = svd(A);  
    F=reshape(V(:,9), 3, 3)';  
    [U D V] = svd(F);

    F = U*diag([D(1,1) D(2,2) 0])*V';

end

