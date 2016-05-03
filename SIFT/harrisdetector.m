function [output,Idx,Idy] = harrisdetector(I,alpha,sigma,threshold)

    if (nargin < 4)
        threshold = 500000;
    end

    if (nargin < 3)
        sigma = 0.5;
    end

    ancho = max(ceil(6*sigma), 1);

    S = fspecial('sobel');
    G = fspecial('gaussian', ancho, sigma); 

    if ~isa(I,'double')
        I=double(I);
    end

    Idx = imfilter(I,S');
    Idy = imfilter(I,S);
    %Productos de las derivadas
    Ix2 = Idx .^ 2;
    Iy2 = Idy .^ 2;
    Ixy = Idx .* Idy;

    % Sumatorio de los productos de las derivadas en cada pixel
    Sx2 = conv2(Ix2, G,'same');
    Sy2 = conv2(Iy2, G,'same');
    Sxy = conv2(Ixy, G,'same');

    %im = (Ix2.*Iy2 - Ixy.^2)-alpha*(Ix2+Iy2).^2;
    output = (Sx2.*Sy2 - Sxy.^2)-alpha*(Sx2+Sy2).^2;

    output = output - imdilate(output, [1 1 1; 1 0 1; 1 1 1]);
    output = output-threshold > 0;


end

