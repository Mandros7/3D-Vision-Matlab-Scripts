close all
clear all
clc

alpha = 0.04            %Valor entre 0.04 y 0.06
threshold = 100;     %Limite para el valor de R
sigma = 1.6;              %Ventana gaussiana
semiancho = round(sigma * 3);    %Ancho correspondiente a un 99,9% del area
iteraciones = 5;

I = imread('img_test.jpeg');
Ip = rgb2gray(I);
I = double(Ip);

[numFilas,numColumnas] = size(I);

% [Idx, Idy] = gradient(double(I));
G = fspecial('gaussian', semiancho*2, sigma); 

matrizME = zeros(numFilas,numColumnas,iteraciones);
Rtemp = zeros(numFilas,numColumnas);
[Idx, Idy] = gradient(double(I));

for i=1:iteraciones
    
    [R,Ix,Iy] = multiEscala(alpha,G,Idx,Idy);
    output = R-threshold > 0;
    matrizME(:,:,i) = R.*output - Rtemp;
    
    Idx = Ix;
    Idy = Iy;
    Rtemp = R.*output;
end



resultado = imregionalmax(matrizME);

figure
for r = 1:iteraciones,
    imshow(Ip);
    for p = 1:numFilas,
        for q=1:numColumnas,
            if resultado(p,q,r)>0
                hold on
                plot(q,p,'ro','MarkerSize',5)
            end
        end
    end
    hold off
    pause
end
