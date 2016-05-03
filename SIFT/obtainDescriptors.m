function [ descriptores, puntos_desc ] = obtainDescriptors(I,alpha,sigma,threshold,numbins,ancho)

        if (nargin < 6)
            ancho = 9;
        end
        if (nargin < 5)
            numbins = 36;
        end
        if (nargin < 4)
            threshold = 500000;
        end
        if (nargin < 3)
            sigma  = 2.5;
        end        
        if (nargin < 2)
            alpha  = 0.04;
        end
    
    [numFilas,numColumnas] = size(I);
    [output,Idx,Idy] = harrisdetector(I,alpha,sigma,threshold);

    arguments = sqrt(Idx.^2+Idy.^2);
    angles = atan2(Idy,Idx);

    [index1,index2] = find(output>0);
    matrix = zeros(length(index1),numbins);
    thresholds = zeros(length(index1),1);

    num = 1;
    for x = 1:length(index1)
          if ((index1(x)-floor(ancho/2)>0 && index1(x)+floor(ancho/2)<numFilas)&&...
                  (index2(x)-floor(ancho/2)>0 && index2(x)+floor(ancho/2)<numColumnas))

              [th,histog]=orientationHist(arguments,angles,...
                  index1(x),index2(x),ancho,numbins);
              histog = (histog>th).*histog;
              matrix(x,:) = histog;
              thresholds(x) = th;
              ind = find(histog>0);
              for c=1:length(ind)
                puntos_desc(num,:) = [index2(x),index1(x),histog(ind(c)),(ind(c))*2/numbins*pi];
                descriptores(:,:,num) = descriptorCoords(index1(x),index2(x),(ind(c))*2/numbins*pi, ancho);
                num = num + 1;
              end 
          end
    end
end

