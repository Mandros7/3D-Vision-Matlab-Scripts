function [lista,matriz3d]=invariantedetector(Iin,sigma,k,threshold)

% Comprobacion de parametros introducidos

if ~isa(Iin,'double')
    Iin=double(Iin);
end

if (nargin < 4)
    threshold=0;
end

if (nargin < 3)
    k = 6;
end

if (nargin < 2)
    sigma = 0.5;
end

lista=[];
matriz3d=zeros([size(Iin) k+1]);

% Crear el acumulador con las laplacianas de gausiana

for i=1:k
    ngauss = max(ceil(6*i*sigma), 1); %Ancho del filtro LOG
    if ~mod(ngauss,2)   
        ngauss = ngauss+1;
    end
    k1=(i*sigma)^2*fspecial('log', ngauss, i*sigma);
    filtered = imfilter(Iin,k1);
    maximos = filtered-threshold > 0;
    puntos = filtered.*maximos;
    matriz3d(:,:,i)=puntos;
end
% Matriz de busqueda de maximos locales propuesta
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
           0  0  0; % El punto de interes (en la posicion 14)
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
       
filas=2:(size(matriz3d,1)-1);
columnas=2:(size(matriz3d,2)-1);

%El primer y ultimo filtrado de LOG no es de interes, ya que no se 
%pueden computar maximos locales.
for l=2:k-1
    for m=1:size(indices,1)
        aux(:,:,m)=matriz3d(filas+indices(m,1),columnas+indices(m,2),l+indices(m,3));
    end
    [maximo,posicion]=max(aux,[],3);
    [y,x]=find(posicion==14);
    lista=[lista;x+1 y+1 l*ones(size(x))];
    [minimo,posicion]=min(aux,[],3);
    [y,x]=find(posicion==14);
    lista=[lista;x+1 y+1 l*ones(size(x))];
end


