function [ MIB ] = mib_create( I )

[h_box , l_box , c] = size(I);

MIB = struct();

%On stock l'image
MIB.img = I;

%On stock le mask = image avec des 1
I_mask(:,:,1) = I(:,:,1);
I_mask(:,:,1) = 1;

MIB.mask = I_mask;
%On crée la boite englobante qu'on stock
extrem1 = [ 1 1 ]
extrem2 = [h_box l_box]
MIB.boite = [ extrem1 ; extrem2 ]




%AFFICHER LE MASK ET LES POINTS BOITE ENGLOBANTE

% figure, imshow(logical(MIB.mask));
% title('mask');
% drawnow;
% 
% figure, imshow(uint8(I));
% title('points boite englobante');
% drawnow;
% 
% hold on;
% plot(extrem1,'r*','MarkerSize', 10, 'LineWidth', 1);
% hold on;
% plot(l_box, h_box,'b*','MarkerSize', 10, 'LineWidth', 1);
% 
% legend('extrem1','extrem2');

end

