function [img_out,cell_out] = compr( img_in, red_per)
% COMPR  Compresses an image according to desired percentage.
%   [img_out,cell_out] = compr(img_in,red_per) reduces img_in size
%             by a percentage indicated by red_per(between 0 and 1)
    if ((red_per>=0)&&(red_per<=1))
        [o,p,q] = size(img_in);
        k = round((1-red_per)*p*o/(p+o+1));
        cell_out = cell(1,q);
        for j = 1:1:q
            [U,S,V] = svd(im2double(img_in(:,:,j)));
            U = U(:,1:k);
            V = V(:,1:k);
            S = S(1:k,1:k);
            cell_chan{1} = uint8(U*255);
            cell_chan{3} = uint8(V*255);
            cell_chan{2} = diag(uint8(S*255));
            cell_out{j} = cell2struct(cell_chan,{'U', 'AutoValues', 'V'},2);
            A = U*S*V';
            img_out(:,:,j) = uint8(A*255);
        end
    else
        error('Porcentaje de reduccion no comprendido entre 0 y 1')
    end
end

