clear all
close all
alpha = 0.04            %Valor entre 0.04 y 0.06
threshold = 1000;     %Limite para el valor de R
sigma = 2.5;              %Ventana gaussiana
numbins = 36;
ancho = 9;

%I = imread('img_test.jpeg');
I = imread('img_test2.png');
I = rgb2gray(I);
%I = imrotate(I,45);

[numFilas,numColumnas] = size(I);

[output,Idx,Idy] = harrisdetector(I,alpha,sigma);
output = output-threshold > 0;

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
            descriptores(:,:,num) = obtenerDescriptor(index1(x),index2(x),(ind(c))*2/numbins*pi, ancho);
            num = num + 1;
          end 
      end
%     if index2(x)>5 && index2(x)<numFilas-5
%         if index1(x)>5 && index1(x)<numColumnas-5
%             Area = reshape(angles(index2(x)-5:index2(x)+5,...
%                 index1(x)-5:index1(x)+5),1,121);
%             matrix(x,:)=Area;
%             
%             
%         end
%     end
end


drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} );
figure, imshow(I);
hold on
for p = 1:length(puntos_desc)
    
    endX = round(puntos_desc(p,1)+2*puntos_desc(p,3)*cos(puntos_desc(p,4)));
    endY = round(puntos_desc(p,2)+2*puntos_desc(p,3)*sin(puntos_desc(p,4)));
    p1 = [puntos_desc(p,1),endX];
    p2 = [puntos_desc(p,2),endY];
    drawArrow(p1,p2,'linewidth',3,'color','r');
end
% for p = 1:numFilas,
%     for q=1:numColumnas,
%         if output(p,q)>0
%             plot(q,p,'ro','MarkerSize',5)
%         end
%     end
% end
hold off
figure, imshow(output);