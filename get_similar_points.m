function [ points1 , points2 ] = get_similar_points( I1,I2 )
%Grace à cette fonction on va pouvoir get les points similaire entre les 2
%images
%Pour ensuite calculer l'homographie qui les relie

figure, imshow(uint8(I1));
title('points1');
drawnow;

[pt1]=ginput(4);
pt1=fix(pt1);

AR1 = [pt1(1,1) pt1(1,2)]; %(x,y)
AR2 = [pt1(2,1) pt1(2,2)];
AR3 = [pt1(3,1) pt1(3,2)];
AR4 = [pt1(4,1) pt1(4,2)];
points1 = [ AR1 ; AR2 ; AR3 ; AR4];

hold on;
plot(AR1(1,1),AR1(1,2),'r+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR2(1,1),AR2(1,2),'b+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR3(1,1),AR3(1,2),'g+','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(AR4(1,1),AR4(1,2),'y+','MarkerSize', 10, 'LineWidth', 1);
legend('AR1','AR2','AR3','AR4');



figure, imshow(uint8(I2));
title('points2');

[pt2]=ginput(4);
pt2=fix(pt2);

DP1 = [pt2(1,1) pt2(1,2)]; %(x,y)
DP2 = [pt2(2,1) pt2(2,2)];
DP3 = [pt2(3,1) pt2(3,2)];
DP4 = [pt2(4,1) pt2(4,2)];

points2 = [ DP1 ; DP2 ; DP3 ; DP4];

hold on;
plot(DP1(1,1),DP1(1,2),'r*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP2(1,1),DP2(1,2),'b*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP3(1,1),DP3(1,2),'g*','MarkerSize', 10, 'LineWidth', 1);
hold on;
plot(DP4(1,1),DP4(1,2),'y*','MarkerSize', 10, 'LineWidth', 1);

legend('DP1','DP2','DP3','DP4');


end

