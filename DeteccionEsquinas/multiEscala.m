function [output,Ix,Iy] = multiEscala(alpha,G,Idx,Idy)
    
    %Convolucion de derivadas en cada pixel en x e y
    Ix = conv2(Idx, G,'same');
    Iy = conv2(Idy, G,'same');

    %Productos de las derivadas
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;

    % Sumatorio de los productos de las derivadas en cada pixel
    Sx2 = conv2(Ix2, G,'same');
    Sy2 = conv2(Iy2, G,'same');
    Sxy = conv2(Ixy, G,'same');

    %im = (Ix2.*Iy2 - Ixy.^2)-alpha*(Ix2+Iy2).^2;
    output = (Sx2.*Sy2 - Sxy.^2)-alpha*(Sx2+Sy2).^2;

    output = output - imdilate(output, [1 1 1; 1 0 1; 1 1 1]);

end

