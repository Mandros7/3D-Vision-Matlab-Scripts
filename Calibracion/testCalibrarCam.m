clear all
close all
clc

load('cademo.mat')
data = data3d;

[alpha,beta,theta,x0,y0,K,R,T] = calibrarCam(data(:,1:3),data(:,4:5));

puntos = ones(length(data(:,1)),3);
for i = 1:length(puntos)
    punto = (K*[R T]*[data(i,1:3),1]');
    puntos(i,:) = punto/punto(end); 
end

figure
plot(puntos(:,1),puntos(:,2),'r.')
hold on
plot(data(:,4),data(:,5),'o')
percentage_error = mean(mean(abs(puntos(:,1:2) - data(:,4:5))./data(:,4:5)))