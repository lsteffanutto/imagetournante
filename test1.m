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


I1=double(imread('lena.bmp')); %On get le quadrangle sur I1
[w1 ,h1] = size(I1);

I2=double(imread('barbara.bmp')); %Qu'on remplace par un rectangle de I2
I2 = I2(75:232,448:548); %Rectangle quelconque qu'on fixe
[w2 ,h2] = size(I2);

%HOMOGRAPHIE IMAGE

figure, imshow(uint8(I1));
title('I1 ARR');
drawnow;
[arrive]=ginput(4); %prend un point avec un click de souris
arrive=fix(arrive);

%les quatres points de l'image I1 qu'on veut remplacer:
%POINTS D'ARRIVER DU RECTANGLE
AR1 = [arrive(1,1) arrive(1,2)]
AR2 = [arrive(2,1) arrive(2,2)]
AR3 = [arrive(3,1) arrive(3,2)]
AR4 = [arrive(4,1) arrive(4,2)]

figure, imshow(uint8(I2));
title('I2 DP');
drawnow;

%le rectangle de l'autre image qu'on veut print sur la première
%On le fixe mais on peut aussi le prelever au clique comme en tp image
%POINTS DE DEPART DU RECTANGLE 
DP1 = [1 ,1];
DP2 = [1 ,h2];
DP3 = [w2 ,h2];
DP4 = [w2 ,1];
%On doit regarde où est-ce que ces points sont dans l'image d'arrivée + gde
%puis faire un mask avec

%homographie H_img qui lie le rectangle au quadrangle
[testdepart ,testarrive ,HOMO]=homographie(DP1,DP2,DP3,DP4,AR1,AR2,AR3,AR4);

testarrive2 = [];
testarrive2 = testdepart * HOMO;

MaskARR = double(roipoly(I1,arrive(:,1),arrive(:,2)));


I3 = zeros(w1 ,h1);
I3 = (I3+MaskARR).*255;
figure, imshow(uint8(I3));
title('MaskARR');
drawnow;

%On print I seulement sur le masque relevé

compteurI2 = w2*h2

for i = 1:w1
    for j = 1:h1
        
        
        if compteurI2 > 0
            
            if I3(i,j) == 255
                I3(i,j) = I2((w2*h2)-compteurI2+1);
                compteurI2 = compteurI2 -1
            
            else
                I3(i,j) = I1(i,j);
            end
            
            
        else
            I3(i,j) = I1(i,j);
        end
        
        
    end
end


figure, imshow(uint8(I3));
title('Image finale');
drawnow;

% testhomo = I2.*HOMO


% homographie = [];
% homographie= double(I1.*homo);
% 
% figure, imshow(uint8(test0));



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
