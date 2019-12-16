clear all;
clc;
close all;

% I1=double(imread('lena.bmp'));
% [h1 ,l1] = size(I1);
% I2=double(imread('barbara.bmp'));
% [h2 ,l2] = size(I2);

%f_projection(I1,I2);
%f_extraction(I2,I1)²²²²²²²²²²²²²²²²²²²²²²;

%% Images de départ
%Image de départ à partir de laquel on fabrique 2 image possédant
% les deux personnages au milieu en commun 
I3=double(imread('bdx.jpg'));
[h3 ,l3, c] = size(I3);

%image mosaique 1 = image 3 tronque
img1 = I3(1:362,1:400,:);

% figure, imshow(uint8(img1));
% title('img1 mosaique');
% drawnow;

%image mosaique 2 = extraction d'une partie de image 3

img2=f_extraction2(I3,img1);

% figure, imshow(uint8(img2));
% title('img2 mosaique');
% drawnow;

%% Création des MIB
% MIB = image + image en mask + boite en globante (2 coins extrem)

[ mib1 ] = mib_create( img1 );
[ mib2 ] = mib_create( img2 );

%% On sélectionne les points que les images ont en communs pour connaitre l'homographie qui les relie

% [ pts_img1 , pts_img2 ] = get_similar_points( img1,img2 );

% [HOMOG]=homographie(pts_img2(1,:),pts_img2(2,:),pts_img2(3,:),pts_img2(4,:),pts_img1(1,:),pts_img1(2,:),pts_img1(3,:),pts_img1(4,:));
% H=[HOMOG(1,1) HOMOG(2,1) HOMOG(3,1);HOMOG(4,1) HOMOG(5,1) HOMOG(6,1); HOMOG(7,1) HOMOG(8,1) 1];

Htest_fixe = [ 0.175197452221173 -0.220574752903233 315.735732267322 ; 0.0136147637091835 0.216174576108749 250.335977405573; 0.000109942879684181 -0.000506109592751219 1 ];

%% On leur applique l'homographie à la mib

[ mib2_homo ] = mib_apply_homo( mib2 , Htest_fixe);
%[ mib2_homo ] = mib_apply_homo( mib1 , Htest_fixe);


% image2_homo = mib2_homo.img;
% figure, imshow(uint8(image2_homo));
% title('mib.img recorded');
% drawnow;

%% On les fusionne








% PAS TOUCHER YA DES TRUCS QUI VONT SERVIR

% DP1 = [1 ,1];
% DP2 = [l3 ,1];
% DP3 = [l3 ,h3];
% DP4 = [1 ,h3];
% 
% %On extrait l'image et son mask
% [Imagette1, MaskARR1, Imagette1_X, Imagette1_Y ]=f_extraction(I3,I1);
% 
% % [Imagette2, MaskARR2, ]=f_extraction(I3,I2);
% 
% 
% hold on;
% plot(Imagette1_X(1,1),Imagette1_Y(1,1),'r+','MarkerSize', 10, 'LineWidth', 1); %Point min
% hold on;
% plot(Imagette1_X(1,2),Imagette1_Y(1,2),'b+','MarkerSize', 10, 'LineWidth', 1); %Point max
% 
% l_box = Imagette1_X(1,2)-Imagette1_X(1,1);
% h_box = Imagette1_Y(1,2)-Imagette1_Y(1,1);
% 
% I_box = zeros(h_box,l_box);
% 
% for i = 1:h_box
%     for j = 1:l_box
%         
%         I_box(i,j) = 255;
%         
%     end
%     
% end
% 
% figure, imshow(uint8(I_box));
% title('Box');
% drawnow;
% 
% % figure, imshow(uint8(Imagette2));
% % title('Imagette2');
% % drawnow;
% % 
% % Mask = MaskARR1.*255 + MaskARR2.*127;
% % 
% % Cross_Mask = Mask > 255;
% % 
% % % figure, imshow(uint8(Cross_Mask.*255));
% % % title('cross mask');
% % % drawnow;
% % 
% % % boite en globante avec les mask ta vu
% % Mask = Mask - Cross_Mask.*170;
% % figure, imshow(uint8(Mask));
% % title('50 nuanshes dé mashk');
% % drawnow;
% % 
% % Boite en globante:
% % [ B1, B2 , B3 , B4 ] = f_boite_englobante(Mask);
% % 
% % J = imrotate(I3,1000*(pi/180));
% % 
% % DP1=DP1*1000*(pi/180);
% % DP2=DP2*1000*(pi/180);
% % DP3=DP3*1000*(pi/180);
% % DP4=DP4*1000*(pi/180);
% % 
% % DP = [DP1 ; DP2 ; DP3; DP4];
% % figure, imshow(uint8(J));
% % title('Imrotate');
% % drawnow;






