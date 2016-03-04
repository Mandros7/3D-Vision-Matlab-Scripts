%Adicion de ruido Gaussiano a las coordenadas percibidas por la 
% camara, que luego son usadas en calibracion
% con el consiguiente efecto en la obtencion de puntos
% a partir de los parametros obtenidos.

% Se muestran los resultados de calibracion para diferentes
% valores de calidad Señal/Ruido medida en dB.

XLIM = 800;
YLIM = 600;

load('cademo.mat')
data = data3d;
for j=40:-1:20

    data_noise = [awgn(data(:,4),j,'measured')...
        awgn(data(:,5),j,'measured')];

    [alpha,beta,theta,x0,y0,K,R,T] = calibrarCam(data(:,1:3),data_noise);

    puntos = ones(length(data(:,1)),3);
    for i = 1:length(puntos)
        punto = (K*[R T]*[data(i,1:3),1]');
        puntos(i,:) = punto/punto(end); 
    end

    plot(puntos(:,1),puntos(:,2),'rx')
    hold on
    plot(data(:,4),data(:,5),'o')
    hold off
    xlim([0 XLIM])
    ylim([0 YLIM])
    str = sprintf('Relacion S/N de %d dB',j);
    title(str)
    pause
end