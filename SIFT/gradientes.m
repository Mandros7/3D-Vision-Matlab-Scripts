function [arguments,angles] = gradientes(Idx,Idy)
%GRADIENTES Summary of this function goes here
%   Detailed explanation goes here
    arguments = sqrt(Idx.^2+Idy.^2);
    angles = atan(Idy./Idx);

end

