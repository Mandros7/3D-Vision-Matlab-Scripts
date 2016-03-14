function [x,y,R,Iout]=harris(Iin,umbral,sigma)
% Implementacion del detector de esquinas de Harris

if (nargin < 3)
    sigma = 0.5;
end

if (nargin < 2)
    umbral = 1e3;
end

% Inicializacion:
% filtro de sobel horizontal (el vertical se obtiene trasponiendo)
k1=fspecial('sobel');
% filtro de gausiana
ngauss = max(ceil(6*sigma), 1);
if ~mod(ngauss,2)    % asegurar que es impar
    ngauss = ngauss+1;
end
k2=fspecial('gaussian', ngauss, sigma);

if ~isa(Iin,'double')
    Iin=double(Iin);
end

% Paso 1: Obtener los gradientes suavizados
Ix=imfilter(Iin,k1);
GIx2=imfilter(Ix.^2,k2);
Iy=imfilter(Iin,k1');
GIy2=imfilter(Iy.^2,k2);
GIxy=imfilter(Ix.*Iy,k2);

% Paso 2: Calcular la metrica de Harris
% R=det(M)-k*tr(M)^2
% con M=[GIx^2 GIx*GIy; GIx*GIy GIy^2]
k=0.04;
R=(GIx2.*GIy2 - GIxy.^2) - k*(GIx2 + GIy2).^2; % medida original de Harris

% Paso 3: Eliminacion de no-maximos
k3=strel('square',3);
Rdilatada=imdilate(R,k3);
R(Rdilatada~=R)=0;

% Paso 4: Umbralizar
R(R<umbral)=0;

% Devolver los parametros
[y,x]=find(R);
Iout=R;
R=R(R(:)>0);