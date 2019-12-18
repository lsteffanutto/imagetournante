function [ mib ] = mib_apply_homo( mib , H)

%% On recup la mib en entree
[extrem1Y]= mib.boite(1,1);
[extrem1X]= mib.boite(1,2);
[extrem2Y]= mib.boite(2,1);
[extrem2X]= mib.boite(2,2);

mask = mib.mask;
img = mib.img;

[h ,l, c] = size(img);

%% On regarde avant homo
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

%% Pour obtenir la boite englobante de l image homo   

Xmin = min(coin1(1,1),coin4(1,1))
Xmax = max(coin2(1,1),coin3(1,1))
Ymin = min(coin1(1,2),coin2(1,2))
Ymax = max(coin3(1,2),coin4(1,2))

largeur_box_homo = Xmax-Xmin %Largeur / Longueur boite englobante
hauteur_box_homo = Ymax-Ymin

coin1_box(1, :) = [ Xmin Ymin ];   %4 points de la nouvelle boite
coin2_box(1, :) = [ Xmax Ymin ];
coin3_box(1, :) = [ Xmax Ymax ];
coin4_box(1, :) = [ Xmin Ymax ];

%% On applique l'homo à l'image (Vrai rep prochain %%)

%ICI ON A GARDER LES DIMENSSIONS DE LIMAGE DE BASE MEME SI HOMO IMAGE

% img_homo(:,:,:)=zeros(h+hauteur_box_homo,l+largeur_box_homo,c);
% 
% for i=1:h+50
%     for j=1:l+50
%         a=inv(H)*[j;i;1];   
%         a(1,1)=a(1,1)/a(3,1); 
%         a(2,1)=a(2,1)/a(3,1);
%         
%         if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
%             
%             img_homo(i,j,:)=img(round(a(2,1)),round(a(1,1)),:); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
% %             img_homo(i,j,:);
%         else
%             %img_homo(i,j,:)=img(i,j,:);
%         end
%         
%     %a=zeros(3,1);
%     end
% end
% 
% %On regarde après homo
% 
% figure, imshow(uint8(img_homo));
% title('mib après homo');
% drawnow;
% 
% hold on;
% plot(coin1(1,1),coin1(1,2),'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(coin2(1,1),coin2(1,2),'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(coin3(1,1),coin3(1,2),'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(coin4(1,1),coin4(1,2),'yo','MarkerSize', 10, 'LineWidth', 1);
% 
% %POINTS BOITE de LHOMO
% 
% hold on;
% plot(coin1_box(1,1),coin1_box(1,2),'rX','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(coin2_box(1,1),coin2_box(1,2),'bX','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(coin3_box(1,1),coin3_box(1,2),'gX','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(coin4_box(1,1),coin4_box(1,2),'yX','MarkerSize', 10, 'LineWidth', 1);
% 
% legend('homo1','homo2','homo3','homo4', 'boite1','boite2','boite3','boite4');




%% qu on range dans la boite

img_homo_bis(:,:,:)= zeros(hauteur_box_homo,largeur_box_homo,c);

for i= Ymin:Ymax
    for j= Xmin:Xmax
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            img_homo_bis(i,j,:)=img(round(a(2,1)),round(a(1,1)),:); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
%             img_homo(i,j,:);
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end
img_res(:,:,:) = img_homo_bis(Ymin:end,Xmin:end,:);

%ICI ON A GARDER LES DIMENSSIONS XMIN ET YMIN DE LIMAGE DE BASE MEME SI ON
%SARRETE APRES LA BOITE

% figure, imshow(uint8(img_homo_bis));
% title('img après homo propre');
% drawnow;
% hold on;
% plot(Xmin,Ymin,'co','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax,Ymin,'ro','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmax,Ymax,'go','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(Xmin,Ymax,'yo','MarkerSize', 10, 'LineWidth', 1);
% legend('boite1','boite2','boite3','boite4');

%on AFFICHE LE BON RESULTAT en arrangeant crop
% figure, imshow(uint8(img_res));
% title('img après homo propre crop');
% drawnow;

%% On applique l'homo au mask (MEME CHOSE)

mask_homo(:,:)=zeros(hauteur_box_homo,largeur_box_homo);

%box_homo = [];
for i=Ymin:Ymax
    for j=Xmin:Xmax
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            mask_homo(i,j)=255; % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            %box_homo = [ box_homo ; i j ];
                   
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    end
end
mask_res(:,:) = mask_homo(Ymin:end,Xmin:end);

% figure, imshow(uint8(mask_res));
% title('mask après homo propre crop');
% drawnow;

%% On retourne nouvelle valeur de la mib

mib.mask = mask_res;
mib.img = img_res;

mib.boite(1,1) = Ymin;
mib.boite(1,2) = Xmin;
mib.boite(2,1) = Ymax;
mib.boite(2,2) = Xmax;


end