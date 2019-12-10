function [ mib ] = mib_apply_homo( mib , H)

boite = mib.boite;
mask = mib.mask;
img = mib.img;

[h ,l] = size(img);

img_homo=zeros(h,l,3);

for i=1:h
    for j=1:l
        a=inv(H)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l && round(a(2,1))>0 && round(a(2,1))<h
            
            img_homo(i,j,:)=img(round(a(2,1)),round(a(1,1)),:); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            img_homo(i,j,:)=img(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end

figure, imshow(uint8(img_homo));
title('homo mib.img');
drawnow;

end