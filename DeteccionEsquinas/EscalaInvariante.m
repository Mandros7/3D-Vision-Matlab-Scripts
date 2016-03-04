function [ output ] = EscalaInvariante(I,alpha,sigma,semiancho)
%HARRISINVARIANTE Summary of this function goes here
%   Detailed explanation goes here

    
    [Idx, Idy] = gradient(double(I));
    LOG = fspecial('log', semiancho*2, sigma); 

    %Productos de las derivadas
    Ix2 = Idx .^ 2;
    Iy2 = Idy .^ 2;
    Ixy = Idx .* Idy;

    % Sumatorio de los productos de las derivadas en cada pixel
    Sx2 = conv2(Ix2, LOG,'same');
    Sy2 = conv2(Iy2, LOG,'same');
    Sxy = conv2(Ixy, LOG,'same');

    %im = (Ix2.*Iy2 - Ixy.^2)-alpha*(Ix2+Iy2).^2;
    output = (Sx2.*Sy2 - Sxy.^2)-alpha*(Sx2+Sy2).^2;

    output = output - imdilate(output, [1 1 1; 1 0 1; 1 1 1]);

end

