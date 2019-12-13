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
figure, imshow(uint8(img));
title('mib.img avant homo');
drawnow;

%% On applique l'homo au points

a=inv(H)*[extrem1X;extrem1Y;1];   
a(1,1)=a(1,1)/a(3,1); 
a(2,1)=a(2,1)/a(3,1);
coin_homo1 = coin1(round(a(2,1)),round(a(1,1)));


%% On applique l'homo à l'image

img_homo(:,:,:)=zeros(h,l,c);

for i=1:h
    for j=1:l
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            img_homo(i,j,:)=img(round(a(2,1)),round(a(1,1)),:); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end

%% On applique l'homo au mask
mask_homo(:,:)=zeros(h,l);

for i=1:h
    for j=1:l
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            mask_homo(i,j)=mask_homo(round(a(2,1)),round(a(1,1))); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            %img_homo(i,j,:)=img(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end

%% PLOTS

%On regarde après homo
figure, imshow(uint8(img_homo));
title('mib.img après homo');
drawnow;

hold on;
plot(coin_homo1(1,1),coin_homo1(2,1),'r*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(extrem2X,extrem2Y,'b*','MarkerSize', 10, 'LineWidth', 1);
% 
% legend('extrem1','extrem2');

% figure, imshow(logical(mask_homo));
% title('mask.img après homo');
% drawnow;

end