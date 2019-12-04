clear all;
clc;
close all;

%Ici procédé inverse 

I1=double(imread('lena.bmp')); %Qu'on remplace par un rectangle de I2

[h1 ,l1] = size(I1);

figure, imshow(uint8(I1));
title('I1 DP');
[depart]=ginput(4); %prend un point avec un click de souris
depart=fix(depart);

% Là c'est l'inverse, points de dpéart à sélectionner

%les quatres points de l'image I1 qu'on veut envoyer en homographie inverse:

DP1 = [depart(1,1) depart(1,2)]; %(x,y)
DP2 = [depart(2,1) depart(2,2)];
DP3 = [depart(3,1) depart(3,2)];
DP4 = [depart(4,1) depart(4,2)];

hold on;
plot(DP1(1,1),DP1(1,2),'r+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP2(1,1),DP2(1,2),'b+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP3(1,1),DP3(1,2),'g+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP4(1,1),DP4(1,2),'y+','MarkerSize', 10, 'LineWidth', 1);

legend('DP1','DP2','DP3','DP4');

% Puis les dimensions d'arrivées sont fixes

I2=double(imread('lena.bmp')); %Qu'on remplace par un rectangle de I2
[h2 ,l2] = size(I2);

AR1 = [1 ,1];
AR2 = [l2 ,1];
AR3 = [l2 ,h2];
AR4 = [1 ,h2];

I4=zeros(h2,l2);

figure, imshow(uint8(I4));
title('Points arrivée');
drawnow;

hold on;
plot(AR1,'r*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR2(1,1),AR2(1,2),'b*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR3(1,1),AR3(1,2),'g*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR4(1,1),AR4(1,2),'y*','MarkerSize', 10, 'LineWidth', 1);

legend('AR1','AR2','AR3','AR4');

%homographie H_img qui lie le quadrangle au rectangle
[HOMOG]=homographie(DP1,DP2,DP3,DP4,AR1,AR2,AR3,AR4);
H1=[HOMOG(1,1) HOMOG(2,1) HOMOG(3,1);HOMOG(4,1) HOMOG(5,1) HOMOG(6,1); HOMOG(7,1) HOMOG(8,1) 1];

%On doit regarde où est-ce que les points de depart sont dans le rectangle d'arrivée
%puis les print en homo inverse si ils y sont

for i=1:h2
    for j=1:l2
        a=inv(H1)*[j;i;1];   %C'était inverse inv() au lieu de \
        a(1,1)=a(1,1)/a(3,1); %ON DIVISE PAR LE NOUVEAU S DE LINVERSE DE H1 BORDEL
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l1 && round(a(2,1))>0 && round(a(2,1))<h1
            
            I4(i,j)=I1(round(a(2,1)),round(a(1,1))); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            I4(i,j)=I1(i,j);
        end
        
    %a=zeros(3,1);
    end
end

figure, imshow(uint8(I4));
title('Extraction finale');
drawnow;
