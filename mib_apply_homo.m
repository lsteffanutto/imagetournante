function [ mib ] = mib_apply_homo( mib , H)

[extrem1Y]= mib.boite(1,1);
[extrem1X]= mib.boite(1,2);
[extrem2Y]= mib.boite(2,1);
[extrem2X]= mib.boite(2,2);

coin1 = [ extrem1X ; extrem1Y];
coin2 = [ extrem2X ; extrem2Y];

mask = mib.mask;
img = mib.img;

[h ,l, c] = size(img);

%On regarde avant homo
% figure, imshow(uint8(img));
% title('mib.img avant homo');
% drawnow;

%% On applique l'homo aux points 

% a=inv(H)*[extrem1Y;extrem1X;1];   
% a(1,1)=a(1,1)/a(3,1); 
% a(2,1)=a(2,1)/a(3,1);
% coin_homo1 = coin1(round(a(2,1)),round(a(1,1)));


%% On applique l'homo à l'image

img_homo(:,:,:)=zeros(h,l,c);

for i=1:h
    for j=1:l
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

for i=1:h
    for j=1:l
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if (i==1) && (j==1)
                coin1(1,1) = round(a(2,1));
                coin1(1,2) = round(a(1,1));
        end
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            mask_homo(i,j)=255; % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
                   
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end
coin1
mib.mask = mask_homo;
%% PLOTS

%On regarde après homo
figure, imshow(uint8(img_homo));
title('mib.img après homo');
drawnow;

hold on;
plot(extrem1X,extrem1Y,'r*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(coin1(1,1),coin1(2,1),'rx','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(extrem2X,extrem2Y,'b*','MarkerSize', 10, 'LineWidth', 1);

legend('extrem1','extrem2');

figure, imshow(uint8(mask_homo));
title('mask.img après homo');
drawnow;

end