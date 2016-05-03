clear all
close all
alpha = 0.04;            %Valor entre 0.04 y 0.06
threshold =500000;       %Limite para el valor de R
sigma = 2.5;             %Ventana gaussiana
numbins = 36;
ancho = 9;

I = imread('img_test.jpeg');
I = rgb2gray(I);

[numFilas,numColumnas] = size(I);

[descriptores,puntos_desc] = obtainDescriptors(I,alpha,sigma,threshold,numbins,ancho);

drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} );
figure, imshow(I);

hold on
for p = 1:length(puntos_desc)
    
    endX = round(puntos_desc(p,1)+2*puntos_desc(p,3)*cos(puntos_desc(p,4)));
    endY = round(puntos_desc(p,2)+2*puntos_desc(p,3)*sin(puntos_desc(p,4)));
    p1 = [puntos_desc(p,1),endX];
    p2 = [puntos_desc(p,2),endY];
    drawArrow(p1,p2,'linewidth',3,'color','r');
end

hold off