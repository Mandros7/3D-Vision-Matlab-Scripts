function [lista,acu]=poi_multiescala(Iin,sigma,k,umbral)
% hace una busqueda multiescala de puntos de interes para las escalas
% (sqrt(2))^(i-1)*sigma, donde i varia de 1 a k

% inicializacion
if (nargin < 4)
    umbral=0;
end

if (nargin < 3)
    k = 6;
end

if (nargin < 2)
    sigma = 0.5;
end

lista=[];
acu=zeros([size(Iin) k+1]);

% filtro de gausiana
ngauss = max(ceil(6*sigma), 1);
if ~mod(ngauss,2)    % asegurar que es impar
    ngauss = ngauss+1;
end
k1=fspecial('gaussian', ngauss, sigma);

if ~isa(Iin,'double')
    Iin=double(Iin);
end

% Crear el acumulador con las aproximaciones de las laplacianas de gausiana
% mediante diferencia de gausianas.

I1=Iin;

for l=1:k
%     I2=imfilter(I1,k1);
%     acu(:,:,l+1)=I2-I1;
    ngauss = max(ceil(6*l*sigma), 1);
    if ~mod(ngauss,2)    % asegurar que es impar
        ngauss = ngauss+1;
    end
    k1=(l*sigma)^2*fspecial('log', ngauss, l*sigma);

    acu(:,:,l)=imfilter(Iin,k1);
%     I1=I2;
end

% Buscar maximos locales
indices=[
          -1 -1 -1;
          -1  0 -1;
          -1  1 -1;
           0 -1 -1;
           0  0 -1;
           0  1 -1;
           1 -1 -1;
           1  0 -1;
           1  1 -1;
          -1 -1  0;
          -1  0  0;
          -1  1  0;
           0 -1  0;
           0  0  0; % punto analizado (posicion 14)
           0  1  0;
           1 -1  0;
           1  0  0;
           1  1  0;
          -1 -1  1;
          -1  0  1;
          -1  1  1;
           0 -1  1;
           0  0  1;
           0  1  1;
           1 -1  1;
           1  0  1;
           1  1  1];
filas=2:(size(acu,1)-1);
columnas=2:(size(acu,2)-1);
% acu2=zeros(size(Iin));
for l=2:k-1
    for m=1:size(indices,1)
        tmp(:,:,m)=acu(filas+indices(m,1),columnas+indices(m,2),l+indices(m,3));
    end
    [maximo,posicion]=max(tmp,[],3);
    [y,x]=find(posicion==14);
    lista=[lista;x+1 y+1 l*ones(size(x))];
    [minimo,posicion]=min(tmp,[],3);
    [y,x]=find(posicion==14);
    lista=[lista;x+1 y+1 l*ones(size(x))];
end


