img = imread('test_img.jpg');
figure
subplot(2,3,2)
imshow(img)
title('Imagen original')
subplot(2,3,4)
img_out = compr(img,0.99);
imshow(img_out)
title('Reduccion del 99%')
subplot(2,3,5)
img_out = compr(img,0.95);
imshow(img_out)
title('Reduccion del 95%')
subplot(2,3,6)
img_out = compr(img,0.90);
imshow(img_out)
title('Reduccion del 90%')
imwrite(img_out,'test_img_c.jpg')