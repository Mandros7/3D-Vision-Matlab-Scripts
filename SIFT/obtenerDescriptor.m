function [ descriptor ] = obtenerDescriptor(x0,y0,ang,ancho)
%OBTENERDESCRIPTOR Summary of this function goes here
%   Detailed explanation goes here

    vx = x0-floor(ancho/2):x0+floor(ancho/2);
    vy = y0-floor(ancho/2):y0+floor(ancho/2);
    
    descriptor = zeros(length(vx)*length(vy),2);
    
    pos = 1;
    for i = vx
        for j = vy
            
            x2 = cos(ang)*(i-x0)-sin(ang)*(j-y0)+x0;
            y2 = sin(ang)*(i-x0)+cos(ang)*(j-y0)+y0;
            descriptor(pos,:) = [x2,y2]
            pos = pos + 1;
        end
    end

end

