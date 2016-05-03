threshold = 30;     %Limite para el valor de R
sigma = sqrt(2);              %Ventana gaussiana
resolutionLevels = 5;

I = imread('img_test.jpeg');
I = rgb2gray(I);

[lista,matriz3d]=invariantedetector(I,sigma,resolutionLevels,threshold);


[x,y,z] = size(matriz3d);


figure
imshow(I)
hold on
for p = 1:length(lista)
    switch(lista(p,3))
        case 2
           plot(lista(p,1),lista(p,2),'bo','MarkerSize',5);
        case 3
           plot(lista(p,1),lista(p,2),'ro','MarkerSize',5);
        case 4
           plot(lista(p,1),lista(p,2),'go','MarkerSize',5);
    end
end