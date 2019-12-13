function [ B1, B2 , B3 , B4 ] = f_boite_englobante(mask);

[h ,l] = size(mask);

img_non_vide = [];

hauteur=0;
longueur=0;

for i = 1:h
    
    for j = 1:l
        
        point_a_test = mask(i,j);
        
        if(point_a_test~=0)
            
            img_non_vide = [ img_non_vide point_a_test];
                
        end
        
    end
    
end



end

