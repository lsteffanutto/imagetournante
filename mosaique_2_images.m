clear all;
clc;
close all;

I1=double(imread('lena.bmp'));
[h1 ,l1] = size(I1);
I2=double(imread('barbara.bmp'));
[h2 ,l2] = size(I2);

%f_projection(I1,I2);
%f_extraction(I2,I1);

I3=double(imread('bdx.jpg'));
[h3 ,l3, c] = size(I3);

DP1 = [1 ,1];
DP2 = [l3 ,1];
DP3 = [l3 ,h3];
DP4 = [1 ,h3];

%On extrait l'image et son mask
[Imagette1, MaskARR1, Imagette1_X, Imagette1_Y ]=f_extraction(I3,I1);

%[Imagette2, MaskARR2, ]=f_extraction(I3,I2);

figure, imshow(uint8(I3));
title('Bdx');
drawnow;

hold on;
plot(Imagette1_X(1,1),Imagette1_Y(1,1),'r+','MarkerSize', 10, 'LineWidth', 1); %Point min
hold on;
plot(Imagette1_X(1,2),Imagette1_Y(1,2),'b+','MarkerSize', 10, 'LineWidth', 1); %Point max

l_box = Imagette1_X(1,2)-Imagette1_X(1,1);
h_box = Imagette1_Y(1,2)-Imagette1_Y(1,1);

I_box = zeros(h_box,l_box);

for i = 1:h_box
    for j = 1:l_box
        
        I_box(i,j) = 255;
        
    end
    
end

figure, imshow(uint8(I_box));
title('Box');
drawnow;

% figure, imshow(uint8(Imagette2));
% title('Imagette2');
% drawnow;

% Mask = MaskARR1.*255 + MaskARR2.*127;
% 
% Cross_Mask = Mask > 255;
% 
% % figure, imshow(uint8(Cross_Mask.*255));
% % title('cross mask');
% % drawnow;
% 
% % boite en globante avec les mask ta vu
% Mask = Mask - Cross_Mask.*170;
% figure, imshow(uint8(Mask));
% title('50 nuanshes dé mashk');
%drawnow;

%Boite en globante:
%[ B1, B2 , B3 , B4 ] = f_boite_englobante(Mask);

% J = imrotate(I3,1000*(pi/180));
% 
% DP1=DP1*1000*(pi/180);
% DP2=DP2*1000*(pi/180);
% DP3=DP3*1000*(pi/180);
% DP4=DP4*1000*(pi/180);
% 
% DP = [DP1 ; DP2 ; DP3; DP4];
% figure, imshow(uint8(J));
% title('Imrotate');
% drawnow;






