function [ projection_finale ] = f_projection(I1,I2)

[h1 ,l1] = size(I1);
[h2 ,l2] = size(I2);

figure, imshow(uint8(I1));
title('I1 ARR');
drawnow;

[arrive]=ginput(4);
arrive=fix(arrive);

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

[HOMOG]=homographie(DP1,DP2,DP3,DP4,AR1,AR2,AR3,AR4);
H1=[HOMOG(1,1) HOMOG(2,1) HOMOG(3,1);HOMOG(4,1) HOMOG(5,1) HOMOG(6,1); HOMOG(7,1) HOMOG(8,1) 1];
projection_finale=zeros(h1,l1);

for i=1:h1
    for j=1:l1
        a=inv(H1)*[j;i;1];   %C'était inverse inv() au lieu de \
        a(1,1)=a(1,1)/a(3,1); %ON DIVISE PAR LE NOUVEAU S DE LINVERSE DE H1 BORDEL
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l2 && round(a(2,1))>0 && round(a(2,1))<h2
            
            projection_finale(i,j)=I2(round(a(2,1)),round(a(1,1))); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            projection_finale(i,j)=I1(i,j);
        end
        
    %a=zeros(3,1);
    end
end

% figure, imshow(uint8(projection_finale));
% title('Fonction Projection finale');
% drawnow;

end

