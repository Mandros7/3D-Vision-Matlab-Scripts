function [ M,I ] = checkSolutions(PRecons,P1,P2)
%CHECKSOLUTIONS Summary of this function goes here
%   Detailed explanation goes here
    errors = zeros(1,4);
    for i = 1:4
        for j = 1:1:length(PRecons{i})
            p_1 = P1*[PRecons{i}(j,:) 1]';
            p_2 = P2{i}*[PRecons{i}(j,:) 1]';
                
            if (p_1(3)<0 || p_2(3)<0)
            
                errors(i) = errors(i)+1;
            end
            
        end
        errors(i)
    end

    [m,I] = min(errors);
    M = P2{I};
end

