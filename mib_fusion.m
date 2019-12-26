function [ mib_mosaique ] = mib_fusion( mib1, mib2);

%% On recup les mib en entree %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MIB1

[extrem1Y_1]= mib1.boite(1,1);
[extrem1X_1]= mib1.boite(1,2);
[extrem2Y_1]= mib1.boite(2,1);
[extrem2X_1]= mib1.boite(2,2);

coin1_1(1,:) = [extrem1Y_1 extrem1X_1];
coin2_1(1,:) = [extrem2X_1 extrem1Y_1];
coin3_1(1,:) = [extrem2X_1 extrem2Y_1];
coin4_1(1,:) = [extrem1X_1 extrem2Y_1];

mask1 = mib1.mask;
mask1 = mask1;
img1 = mib1.img;

[h1 ,l1, c] = size(img1);

%boite englobante de l image 1

Xmin_1 = min(coin1_1(1,1),coin4_1(1,1));
Xmax_1 = max(coin2_1(1,1),coin3_1(1,1));
Ymin_1 = min(coin1_1(1,2),coin2_1(1,2));
Ymax_1 = max(coin3_1(1,2),coin4_1(1,2));

largeur_box_1 = Xmax_1-Xmin_1; %Largeur / Longueur boite englobante1
hauteur_box_1 = Ymax_1-Ymin_1;

coin1_box_1(1, :) = [ Xmin_1 Ymin_1 ];   %4 points de la boite1
coin2_box_1(1, :) = [ Xmax_1 Ymin_1 ];
coin3_box_1(1, :) = [ Xmax_1 Ymax_1 ];
coin4_box_1(1, :) = [ Xmin_1 Ymax_1 ];

%% MIB2

[extrem1Y_2]= mib2.boite(1,1);
[extrem1X_2]= mib2.boite(1,2);
[extrem2Y_2]= mib2.boite(2,1);
[extrem2X_2]= mib2.boite(2,2);

coin1_2(1,:) = [extrem1Y_2 extrem1X_2]
coin2_2(1,:) = [extrem2X_2 extrem1Y_2];
coin3_2(1,:) = [extrem2X_2 extrem2Y_2];
coin4_2(1,:) = [extrem1X_2 extrem2Y_2]

mask2 = mib2.mask;
mask2 = mask2./255;
mask2 = mask2.*2;
img2 = mib2.img;

[h2 ,l2, c] = size(img2);

%boite englobante de l image 2

Xmin_2 = coin4_2(1,1);
Xmax_2 = max(coin2_2(1,1),coin3_2(1,1));
Ymin_2 = min(coin1_2(1,2),coin2_2(1,2));
Ymax_2 = max(coin3_2(1,2),coin4_2(1,2));

largeur_box_2 = Xmax_2-Xmin_2; %Largeur / Longueur boite englobante2
hauteur_box_2 = Ymax_2-Ymin_2;

coin1_box_2(1, :) = [ Xmin_2 Ymin_2 ];   %4 points de la boite1
coin2_box_2(1, :) = [ Xmax_2 Ymin_2 ];
coin3_box_2(1, :) = [ Xmax_2 Ymax_2 ];
coin4_box_2(1, :) = [ Xmin_2 Ymax_2 ];


%% On verif la recup des mib 1 et 2

% %MIB1
% figure, imshow(uint8(img1));
% title('mib1.img1');
% drawnow;
% figure, imshow(uint8(mask1));
% title('mib1.mask1');
% drawnow;
% 
% figure,
% plot(Xmin_1,Ymin_1,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_1,Ymin_1,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_1,Ymax_1,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin_1,Ymax_1,'yo','MarkerSize', 10, 'LineWidth', 1);
% title('points boite mib 1');
% legend('boite1','boite2','boite3','boite4');
% 
% %MIB2
figure, imshow(uint8(img2));
title('mib2.img2');
drawnow;
figure, imshow(uint8(mask2));
title('mib2.mask2');
drawnow;
% 
% figure,
% plot(Xmin_2,Ymin_2,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_2,Ymin_2,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_2,Ymax_2,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin_2,Ymax_2,'yo','MarkerSize', 10, 'LineWidth', 1);
% title('points boite mib 2');
% legend('boite1','boite2','boite3','boite4');

% Fin recup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% On fusionne les boites

%boite englobante de l image 3

Xmin_3 = min(coin1_1(1,1),coin1_2(1,1));
Xmax_3 = max(coin2_1(1,1),coin2_2(1,1));
Ymin_3 = min(coin1_1(1,2),coin1_2(1,2));
Ymax_3 = max(coin3_1(1,2),coin3_2(1,2));

largeur_box_3 = Xmax_3-Xmin_3+1; %Largeur / Longueur boite englobante1
hauteur_box_3 = Ymax_3-Ymin_3+1;

coin1_box_3(1, :) = [ Xmin_3 Ymin_3 ];   %4 points de la boite fusion
coin2_box_3(1, :) = [ Xmax_3 Ymin_3 ];
coin3_box_3(1, :) = [ Xmax_3 Ymax_3 ];
coin4_box_3(1, :) = [ Xmin_3 Ymax_3 ];

% figure,
% plot(Xmin_3,Ymin_3,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_3,Ymin_3,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_3,Ymax_3,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin_3,Ymax_3,'yo','MarkerSize', 10, 'LineWidth', 1);
% 
% title('points boite mib fusion');
% legend('boite1','boite2','boite3','boite4');


%% On fusionne les mask

mask_fusion = zeros(hauteur_box_3,largeur_box_3); 


mask1_redim=zeros(hauteur_box_3,largeur_box_3);
mask2_redim=zeros(hauteur_box_3,largeur_box_3);

%Mask1 redim
for i = 1:hauteur_box_3
    for j = 1:largeur_box_3
        
        if i>Xmin_1 && i<Xmax_1 && j>Ymin_1 && j<Ymax_1
            if mask1(j-Ymin_1,i-Xmin_1) ~= 0
                mask1_redim(j,i) = mask1(j-Ymin_1,i-Xmin_1);
            end
        end

    end
end

figure, imshow(uint8(mask1_redim.*255));
title('mask1 redim');
drawnow;


%Mask2 redim
for j = 1:hauteur_box_3
    for i = 1:largeur_box_3
        
        if i>Xmin_2 && i<Xmax_2 && j>Ymin_2 && j<Ymax_2
            if mask2(j-Ymin_2,i-Xmin_2) ~= 0
                mask2_redim(j,i) = mask2(j-Ymin_2,i-Xmin_2);
            end
        end

    end
end

figure, imshow(uint8(mask2_redim.*255));
title('mask2 redim');
drawnow;

mask_fusion_figure = mask1_redim.*255 + mask2_redim.*255;
mask_fusion = mask1_redim + mask2_redim;
% Cross_Mask = mask_fusion > 255;
% mask_fusion = mask_fusion - Cross_Mask.*170;
figure, imshow(uint8(mask_fusion_figure));
title('mask fusion');
drawnow;

hold on;

% plot(Xmin_3,Ymin_3,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_3,Ymin_3,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_3,Ymax_3,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin_3,Ymax_3,'yo','MarkerSize', 10, 'LineWidth', 1);

% plot(Xmin_2,Ymin_2,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_2,Ymin_2,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_2,Ymax_2,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin_2,Ymax_2,'yo','MarkerSize', 10, 'LineWidth', 1);


% plot(Xmin_1,Ymin_1,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_1,Ymin_1,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax_1,Ymax_1,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin_1,Ymax_1,'yo','MarkerSize', 10, 'LineWidth', 1);

% legend('boite1','boite2','boite3','boite4','boite1','boite2','boite3','boite4','boite1','boite2','boite3','boite4');

%% On fusionne les images
image_fusion = zeros(hauteur_box_3,largeur_box_3,3);

% figure, imshow(uint8(image_fusion));
% title('image fusion1');
% drawnow;

for j = 1:hauteur_box_3
    for i = 1:largeur_box_3
        
            if mask_fusion(j,i) == 1
                image_fusion(j,i,:) = img1(j,i,:);
            end
            
            if mask_fusion(j,i) == 2 || mask_fusion(j,i) == 3
            image_fusion(j,i,:) = img2(j-Ymin_2,i-Xmin_2,:);
        end

    end
end

% for i = 1:hauteur_box_3
%     for j = 1:largeur_box_3
%         
%         if mask_fusion(i,j) == 1
%             image_fusion(i,j,:) = img1(i-Xmin_1,j-Ymin_1,:);
%         end
%         
%         if mask_fusion(i,j) == 2 || mask_fusion(i,j) == 3
%             image_fusion(i,j,:) = img2(i-Xmin_2,j-Ymin_2,:);
%         end
% 
%     end
% end

figure, imshow(uint8(image_fusion));
title('image fusion finale');
drawnow;






mib_mosaique = 1;


end
