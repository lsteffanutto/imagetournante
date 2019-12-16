function [ mib ] = mib_apply_homo( mib , H)

[extrem1Y]= mib.boite(1,1);
[extrem1X]= mib.boite(1,2);
[extrem2Y]= mib.boite(2,1);
[extrem2X]= mib.boite(2,2);

mask = mib.mask;
img = mib.img;

[h ,l, c] = size(img);

%On regarde avant homo
% figure, imshow(uint8(img));
% title('mib.img avant homo');
% drawnow;

%% On applique l'homo aux points boîte englobante

coin1(1,:) = [extrem1Y extrem1X];
coin2(1,:) = [extrem2X extrem1Y];
coin3(1,:) = [extrem2X extrem2Y];
coin4(1,:) = [extrem1X extrem2Y];

a=H*[extrem1Y;extrem1X;1];   
a(1,1)=a(1,1)/a(3,1); 
a(2,1)=a(2,1)/a(3,1);
coin1(1,:) = [  round(a(1,1)) round(a(2,1)) ];

a=H*[extrem2X;extrem1Y;1];   
a(1,1)=a(1,1)/a(3,1); 
a(2,1)=a(2,1)/a(3,1);
coin2(1,:) = [  round(a(1,1)) round(a(2,1)) ];

a=H*[extrem2X;extrem2Y;1];   
a(1,1)=a(1,1)/a(3,1); 
a(2,1)=a(2,1)/a(3,1);
coin3(1,:) = [  round(a(1,1)) round(a(2,1)) ];

a=H*[extrem1X;extrem2Y;1];   
a(1,1)=a(1,1)/a(3,1); 
a(2,1)=a(2,1)/a(3,1);
coin4(1,:) = [  round(a(1,1)) round(a(2,1)) ];

%% Pour obtenir la boite englobante homo
Xmin = min(coin1(1,1),coin4(1,1));
Xmax = max(coin2(1,1),coin3(1,1));
Ymin = min(coin1(1,2),coin2(1,2));
Ymax = max(coin3(1,2),coin4(1,2));

largeur_box_homo = Xmax-Xmin;
hauteur_box_homo = Ymax-Ymin;


coin1_box(1, :) = [ Xmin Ymin ];   %4 points de la nouvelle boite
coin2_box(1, :) = [ Xmax Ymin ];
coin3_box(1, :) = [ Xmax Ymax ];
coin4_box(1, :) = [ Xmin Ymax ];

boitehomo(:,:) = zeros(hauteur_box_homo, largeur_box_homo);

figure, imshow(uint8(boitehomo));
title('boite nouvelle homo');
drawnow;



%% On applique l'homo à l'image

img_homo(:,:,:)=zeros(h+hauteur_box_homo,l+largeur_box_homo,c);

for i=1:h+50
    for j=1:l+50
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            img_homo(i,j,:)=img(round(a(2,1)),round(a(1,1)),:); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
%             img_homo(i,j,:);
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end
mib.img = img_homo;

%% On applique l'homo au mask
mask_homo(:,:)=zeros(h,l);
box_homo = [];
for i=1:h
    for j=1:l
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            mask_homo(i,j)=255; % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            box_homo = [ box_homo ; i j ];
                   
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    end
end


mib.mask = mask_homo;

%% On en déduit la boite englobante
extrem1Y=min(box_homo(:,1)) %hauteur
extrem1X=min(box_homo(:,2)) %largeur

extrem2Y=max(box_homo(:,1)) %hauteur
extrem2X=max(box_homo(:,2)) %largeur

%On enregistre les nouveaux points dans la mib
mib.boite(1,1) = extrem1Y;
mib.boite(1,2) = extrem1X;
mib.boite(2,1) = extrem2Y;
mib.boite(2,2) = extrem2X;

largeur_box_homo = extrem2X - extrem1X;
hauteur_box_homo = extrem2Y - extrem1Y;
box_englobante_homo(:,:)=zeros(hauteur_box_homo,largeur_box_homo);


%% PLOTS

%On regarde après homo
figure, imshow(uint8(img_homo));
title('mib.img après homo');
drawnow;

%EXTREMUMS BOITE ENGLOBANTE


%4 COINS BOITE ENGLOBANTE
% hold on;
% plot(extrem1X,extrem1Y,'gX','MarkerSize', 15, 'LineWidth', 1);
% hold on;
% plot(extrem2X,extrem1Y,'bX','MarkerSize', 15, 'LineWidth', 1);
% hold on;
% plot(extrem2X,extrem2Y,'rX','MarkerSize', 15, 'LineWidth', 1);
% hold on;
% plot(extrem1X,extrem2Y,'yX','MarkerSize', 15, 'LineWidth', 1);


%POINTS HOMO
hold on;
plot(coin1(1,1),coin1(1,2),'co','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin2(1,1),coin2(1,2),'ro','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin3(1,1),coin3(1,2),'go','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin4(1,1),coin4(1,2),'yo','MarkerSize', 10, 'LineWidth', 1);

%POINTS BOITE de LHOMO
hold on;
plot(coin1_box(1,1),coin1_box(1,2),'rX','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin2_box(1,1),coin2_box(1,2),'bX','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin3_box(1,1),coin3_box(1,2),'gX','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin4_box(1,1),coin4_box(1,2),'yX','MarkerSize', 10, 'LineWidth', 1);

legend('homo1','homo2','homo3','homo4', 'boite1','boite2','boite3','boite4');

%MASK
figure, imshow(uint8(mask_homo));
title('mask.img après homo');
drawnow;

end