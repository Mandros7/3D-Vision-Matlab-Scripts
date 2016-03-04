function [ output] = harrisdetector(alpha,sigma,semiancho,I)

%La derivada de la convolucion 2D de los puntos con una gaussiana 
% es lo mismo que la convolucion con la derivada de la gaussiana
% uso de la funcion conv2

[Idx, Idy] = gradient(double(I));
G = fspecial('gaussian', semiancho*2, sigma); 

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

end

