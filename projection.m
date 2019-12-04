clear all;
clc;
close all;

I1=double(imread('lena.bmp')); %On get le quadrangle sur I1
[h1 ,l1] = size(I1);

I2=double(imread('barbara.bmp')); %Qu'on remplace par un rectangle de I2
%I2 = I2(75:232,448:548); %Rectangle quelconque qu'on fixe
[h2 ,l2] = size(I2);

figure, imshow(uint8(I1));
title('I1 ARR');
drawnow;
[arrive]=ginput(4); %prend un point avec un click de souris
arrive=fix(arrive);

%les quatres points de l'image I1 qu'on veut remplacer:
%POINTS D'ARRIVER DU RECTANGLE
AR1 = [arrive(1,1) arrive(1,2)]; %(x,y)
AR2 = [arrive(2,1) arrive(2,2)];
AR3 = [arrive(3,1) arrive(3,2)];
AR4 = [arrive(4,1) arrive(4,2)];

hold on;
plot(AR1(1,1),AR1(1,2),'r+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR2(1,1),AR2(1,2),'b+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR3(1,1),AR3(1,2),'g+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR4(1,1),AR4(1,2),'y+','MarkerSize', 10, 'LineWidth', 1);
legend('AR1','AR2','AR3','AR4');

%le rectangle de l'autre image qu'on veut print sur la première
%On le fixe mais on peut aussi le prelever au clique comme en tp image
%POINTS DE DEPART DU RECTANGLE 
DP1 = [1 ,1];
DP2 = [l2 ,1];
DP3 = [l2 ,h2];
DP4 = [1 ,h2];

figure, imshow(uint8(I2));
title('I2 DP');

hold on;
plot(DP1,'r*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP2(1,1),DP2(1,2),'b*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP3(1,1),DP3(1,2),'g*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP4(1,1),DP4(1,2),'y*','MarkerSize', 10, 'LineWidth', 1);

legend('DP1','DP2','DP3','DP4');


%On doit regarde où est-ce que ces points sont dans l'image d'arrivée + gde
%puis faire un mask avec

%homographie H_img qui lie le rectangle au quadrangle
[HOMOG]=homographie(DP1,DP2,DP3,DP4,AR1,AR2,AR3,AR4);
H1=[HOMOG(1,1) HOMOG(2,1) HOMOG(3,1);HOMOG(4,1) HOMOG(5,1) HOMOG(6,1); HOMOG(7,1) HOMOG(8,1) 1];
I4=zeros(h1,l1);

%On parcourt l'image d'arrivée. Pour chaque point, on regard si
% homographie inverse est dans l'image qu'on veut projeter.
%Si oui on print le point qu'on veut projeter sur l'image d'arrivée.

%PROJECTION à faire en fonction
%On parcourt l'image d'arriver en vérifiant si l'homographie inverse de
%chaque point et dans l'autre image ou pas 
%Si oui on balance le point de l'autre en appliquant l'homographie

for i=1:h1
    for j=1:l1
        a=inv(H1)*[j;i;1];   %C'était inverse inv() au lieu de \
        a(1,1)=a(1,1)/a(3,1); %ON DIVISE PAR LE NOUVEAU S DE LINVERSE DE H1 BORDEL
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l2 && round(a(2,1))>0 && round(a(2,1))<h2
            
            I4(i,j)=I2(round(a(2,1)),round(a(1,1))); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            I4(i,j)=I1(i,j);
        end
        
    %a=zeros(3,1);
    end
end

%HOMOGRAPHIE j,i
%IMAGE i,j

%EXTRACTION à faire aussi
        

%testarrive2 = [];
%testarrive2 = testdepart * HOMO;

%MaskARR = double(roipoly(I1,arrive(:,1),arrive(:,2)));


%I3 = zeros(w1 ,h1);
%I3 = (I3+MaskARR).*255;
%figure, imshow(uint8(I3));
%title('MaskARR');
%drawnow;

%On print I seulement sur le masque relevé

% compteurI2 = w2*h2;
% 
% for i = 1:w1
%     for j = 1:h1                
%         if compteurI2 > 0         
%             if I3(i,j) == 255
%                 I3(i,j) = I2((w2*h2)-compteurI2+1);
%                 compteurI2 = compteurI2 -1;           
%             else
%                 I3(i,j) = I1(i,j);
%             end                  
%         else
%             I3(i,j) = I1(i,j);
%         end                
%     end
% end


figure, imshow(uint8(I4));
title('Projection finale');
drawnow;


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


