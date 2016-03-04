alpha = 0.04            %Valor entre 0.04 y 0.06
threshold = 1000;     %Limite para el valor de R
sigma = 2;              %Ventana gaussiana
semiancho = sigma * 3;    %Ancho correspondiente a un 99,9% del area

I = imread('img_test.jpeg');
I = rgb2gray(I);

[numFilas,numColumnas] = size(I);

output = harrisdetector(alpha,sigma,semiancho,I);

output = output-threshold > 0;

figure, imshow(I);
hold on
for p = 1:numFilas,
    for q=1:numColumnas,
        if output(p,q)>0
            plot(q,p,'ro','MarkerSize',5)
        end
    end
end
hold off
figure, imshow(output);