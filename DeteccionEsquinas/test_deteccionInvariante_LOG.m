alpha = 0.06            %Valor entre 0.04 y 0.06
threshold = 90000;     %Limite para el valor de R
sigma = sqrt(2);              %Ventana gaussiana
semiancho = sigma * 3;    %Ancho correspondiente a un 99,9% del area
resolutionLevels = 5;

I = imread('img_test.jpeg');
I = rgb2gray(I);

[X, Y] = size(I);
    
matriz3D = zeros(X,Y,resolutionLevels+1);

    
for n=0:resolutionLevels
  sigma = 1.25^(n-floor(resolutionLevels/2));
  R=EscalaInvariante(I,alpha,sigma,floor(sigma*3));
  maximos = R-threshold > 0;
  puntos = R.*maximos;        
  matriz3D(:,:,n+1) = puntos;  
  %sigma = sigma*sqrt(2);
end

[x,y,z] = size(matriz3D);


BW = imregionalmax(matriz3D);
% for m=2:x-1
%     for n=2:y-1
%         for o=2:z-1
%             V = matriz3D(x-1:x+1,y-1:y+1,z-1:z+1);
%             [max,index]=max(
%         end
%     end
% end



for k=1:z
    figure
    imshow(I);
    hold on
    for p = 1:X,
        for q=1:Y,
            if BW(p,q,k)==1
                    plot(q,p,'bo','MarkerSize',5)
                
            end
            if matriz3D(p,q,k)>0
                plot(q,p,'rx','MarkerSize',5)
                
            end
        end
    end
    hold off
    pause
    close all
end

