function [alpha,beta,theta,x0,y0,K,R,T] = calibrarCam(d3points,d2points)
%CALIBRARCAM Summary of this function goes here
%   Detailed explanation goes here
    Po = d3points;
    x0_P = d2points(:,1);
    y0_P = d2points(:,2);

    P = zeros(length(x0_P)*2,12);
    z = zeros(1,3);

    for k = 1:length(x0_P)
        P(2*k-1:2*k,:) = [Po(k,:),1, z,0, -x0_P(k)*Po(k,:),-x0_P(k);
            z,0, Po(k,:),1, -y0_P(k)*Po(k,:),-y0_P(k)];
    end
    [U,S,V] = svd(P);
    m = V(:, end);
    M = reshape(m, 4, 3)';


    A = M(1:3,1:3);
    b = M(1:3,4);

    [K,R] = miQR(A);
    T = K\b;

    K = K/K(end,end);
    alpha = K(1,1);
    theta = acot(-K(1,2)/alpha);
    beta = K(2,2)*sin(theta);
    x0 = K(1,3);
    y0 = K(2,3);

end

