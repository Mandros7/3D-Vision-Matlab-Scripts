function [K R] = miQR(M)
    [R,K] = qr(flipud(M)');
    
    %Rotar matriz K  180 grados
    K = rot90(K',2); 
    R = R';   
    R = flipud(R);
    
     T = diag(sign(diag(R)));
     R = R * T;
     K = T * K; 
end

