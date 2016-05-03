function [P] = reconstruct( M1, p1, M2, p2 )

P = zeros(size(p1,1),3);

for i=1:1:size(p2,1)
    C = [p1(i,1) * M1(3,:) - M1(1,:); ...
         p1(i,2) * M1(3,:) - M1(2,:); ...
         p2(i,1) * M2(3,:) - M2(1,:); ...
         p2(i,2) * M2(3,:) - M2(2,:)];
    
    [u,s,v] = svd(C); 
    nV = v(:,end)./v(4,end);
    P(i,:) = nV(1:3)';
end

end