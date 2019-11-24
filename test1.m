clear all;
clc;
close all;

M1=[1 2];
M2=[3 4];
M3=[5 6];
M4=[7 8];
M5=[9 10];
M6=[11 12];
M7=[13 14];
M8=[15 16];

[A B H]=homographie(M1,M2,M3,M4,M5,M6,M7,M8);

test = [];
test = A * H;


I1=double(imread('lena.bmp'));

I2=double(imread('barbara.bmp'));

figure, imshow(uint8(I1));

%HOMOGRAPHIE IMAGE
[depart]=ginput(4); %prend un point avec un click de souris
depart=fix(depart);
%les quatres points de l'image qu'on veut remplacer
D1 = [depart(1,1) depart(1,2)];
D2 = [depart(2,1) depart(2,2)];
D3 = [depart(3,1) depart(3,2)];
D4 = [depart(4,1) depart(4,2)];
figure, imshow(uint8(I2));

%le rectangle de l'autre image qu'on veut print sur la première
E1 = [470 96];
E2 = [540 108];
E3 = [521 214];
E4 = [458 223];

[D E homo]=homographie(E1,E2,E3,E4,D1,D2,D3,D4);

homographie = [];
homographie= double(I1.*homo);

figure, imshow(uint8(test0));



% A1= [p1(1)]
% B1= [p1(12)]
% C1= [p3(3)]
% D1= [p1(1)]
% x=fix(x);
% y=fix(y);
%line(x,y);

% sp(1) = min(floor(p(1)), floor(p(2))); %xmin
% sp(2) = min(floor(p(3)), floor(p(4))); %ymin
% sp(3) = max(ceil(p(1)), ceil(p(2)));   %xmax
% sp(4) = max(ceil(p(3)), ceil(p(4)));   %ymax
% Index into the original image to create the new image
% MM = I1(sp(2):sp(4), sp(1): sp(3),:);
MM = double(roipoly(I1,depart));
figure,imshow(MM);
% figure,imshow(I1);
% Iextract = [];
%
% for i = 1:512
%     for j = 1:512
%          if MM(i,j) == 1
%             Iextract(i,j)=I2(i,j);
%          end
%     end
% end
%
% figure,imshow(Iextract);

% % Read image from graphics file.
%
% % Display image with true aspect ratio
% image(I1); axis image
% % Use ginput to select corner points of a rectangular
% % region by pointing and clicking the mouse twice
% p = ginput(2);
% % Get the x and y corner coordinates as integers
% sp(1) = min(floor(p(1)), floor(p(2))); %xmin
% sp(2) = min(floor(p(3)), floor(p(4))); %ymin
% sp(3) = max(ceil(p(1)), ceil(p(2)));   %xmax
% sp(4) = max(ceil(p(3)), ceil(p(4)));   %ymax
% % Index into the original image to create the new image
% MM = I1(sp(2):sp(4), sp(1): sp(3),:);
% %Display the subsetted image with appropriate axis ratio
% figure; image(MM); axis image
