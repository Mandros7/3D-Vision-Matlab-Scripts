alpha = 0.04            %Valor entre 0.04 y 0.06
threshold = 10000;     %Limite para el valor de R
sigma = 2.5;              %Ventana gaussiana

I = imread('img_test.jpeg');
I = rgb2gray(I);

[numFilas,numColumnas] = size(I);

output = harrisdetector(I,alpha,sigma,threshold);

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
%figure, imshow(output);