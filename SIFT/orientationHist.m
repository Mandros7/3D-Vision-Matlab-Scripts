function [thresh,ortHist] = orientationHist(grad, ort, x, y, ancho,num_bins)

	[M,N] = size(grad);

    ancho = 9;
	ortHist = zeros(num_bins, 1);

    
    vx = x-floor(ancho/2):x+floor(ancho/2);
    vy = y-floor(ancho/2):y+floor(ancho/2);

	% iterate through all points in the window
	for i = vx
		for j = vy
			gradVal = grad(i, j);
			if (gradVal > 0)				
				ortAng = ort(i, j);
				binNo = round(num_bins * (ortAng + pi) / (2 * pi));
                if (binNo == 0)
					binNo = num_bins;
                end	
				ortHist(binNo) = ortHist(binNo) + 1;			
			end
		end
	end

	% smooth the histogram
	%ortHist = smoothHist(ortHist);

	% the threshold for creating a keypoint is 80% of the 
	% highest peak in the histogram
	thresh = 0.8 * max(ortHist);

end
