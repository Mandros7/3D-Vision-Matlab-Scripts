clear all
close all

%w: nivel de confianza
%p: porcentaje de inliers en el modelo
p = 0.95;
w = 0.9;
th = 0.1;

I1 = imread('./images/001.jpg');
I2 = imread('./images/002.jpg');
%I3 = imread('./images/002.jpg');

I1 = rgb2gray(I1);
[M,N] = size(I1);
I2 = rgb2gray(I2);
% I3 = rgb2gray(I3);
% [M3,N3] = size(I3);

mP = load('./2D/nview-corners');

c1 = load('./2D/001.corners');
c2 = load('./2D/002.corners');
%c3 = load('./2D/003.corners');

mPoints = matchPoints(mP,1,3);

c1 = c1(mPoints(:,1)+1,:);
c2 = c2(mPoints(:,2)+1,:);

M1 = load('./2D/001.P');
M2 = load('./2D/002.P');
%K3 = load('./2D/003.P');

s1 = length(c1); 
s2 = length(c2); 

c1=[c1(:,1) c1(:,2) ones(s1,1)];  
c2=[c2(:,1) c2(:,2) ones(s2,1)]; 

% The matrix for normalization(Centroid)  
norm=[2/N 0 -1;  
    0 2/M -1;  
    0   0   1];    

x1 = norm*c1';
x2 = norm*c2';

x2_1 = x2(:,1:floor(length(x2)*0.05));
x2_2 = x2(:,floor(length(x2)*0.05)+1:length(x2));

idx = randperm(length(x2_1));

x2 = [x2_1(:,idx) x2_2];

[F,errores] = ransacF(x1,x2,p,w,th);

%[F] = eightpoints(x1,x2);

F = norm'*F*norm;

[K1,R1] = miQR(M1(1:3,1:3));
[K2,R2] = miQR(M2(1:3,1:3));

%E = -1*(K1'*F*K2);
E = (K1'*F*K2);

[U,S,V] = svd(E);

Z = [0 1 0;-1 0 0; 0 0 0];
W = [0 -1 0;1 0 0; 0 0 1];

tx = U*Z*U';
t1 = U(:,3);
t2 = -t1;
R1 = U*W*V';
R2 = U*W'*V';

P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];


P2 = cell(1,4);
% P2{1} = [K2*R1 -K2*R1'*t1]; 
% P2{2} = [K2*R1 -K2*R1'*t2]; 
% P2{3} = [K2*R2 -K2*R2'*t1]; 
% P2{4} = [K2*R2 -K2*R2'*t2]; 

P2{1} = [K2*R1 -K2*t1]; 
P2{2} = [K2*R1 -K2*t2]; 
P2{3} = [K2*R2 -K2*t1]; 
P2{4} = [K2*R2 -K2*t2]; 

PRecons = cell(1,4);
for i=1:4
    PRecons{i} = reconstruct(P1,c1,P2{i},c2);
end

[P2_final,index_P] = checkSolutions(PRecons,P1,P2);

P3D = PRecons{index_P};




