function [image, LUT] = sunset(n, m, l, f, h, E, B)
%sunset: une jolie image d'un coucher du soleil
%Paramètres:
%   n : largeur du capteur (mm)
%   m : hauteur du capteur (mm)
%   l : taille du pixel (mm)
%   f : distance focale (mm)
%   h : hauter du sténopé (mm?)
%   E : inclinaison du soleil (deg)
%   B : vecteur de position de l'objet (par rapport le sténopé) (mm?)
%   image : l'image
%   LUT : Look Up Table des couleurs

%LUT DES COULEURS
LUT = LUT_colors;

%PIXELS
n = floor(n/l);    m = floor(m/l);

%MER
image = ones(m,n);

%SOLEIL
E = E*pi/180;    %inclinaison du soleil
S = [0, -cos(E), -sin(E)];  %vecteur des rayons du soleil
    
%OBJET A DISTANCE FINIE
L = 1;  %taille de l'objet (mm)

for j = 1:n     %boucle horizontale    
    for i = 0:m/2-1  %boucle verticale (mer/reflet)        
        
        %VECTEUR D'OBSERVATION
        O = [(j-n/2-1)*l, f, (i-m/2-1)*l];  %vecteur d'observation
        O = O .* abs(h/O(3)); %taille réelle (sténopé -> eau)
        d = norm(O); %distace de la mer
        
        %NORMALE OBJET
        P = O - B;  %rayon objet
        P = P ./ norm(P);
        O = O ./ norm(O);
        M = -O - P;    %vecteur normale à surface (rayon objet)
        M = M ./ norm(M);
        alpha_obj = acos(M(3)); %angle de la normale
        
        %NORMALE SOLEIL
        N = - O - S;    %vecteur normale à surface (rayon soleil)
        N = N ./ norm(N);
        alpha_sun = acos(N(3));	%angle de la normale
        
        %VAGUES
        if sin(d) > 0.5 %phase des vagues
            image(m-i,j) = 4; %vagues
        end
        
        %ANISOTROPIE SOLEIL
        A = N(1:2);  %projection de N dans le plan XY
        A = A ./ norm(A);
        phi = asin(A(1));  %angle de la normale (dans le plan XY) ~1e-3rad
        alpha_max = alpha_m(phi,d);
        
        %REFLET DU SOLEIL
        if alpha_sun < alpha_max(1)
            image(m-i,j) = 5;
        elseif alpha_sun < alpha_max(2)
            image(m-i,j) = 6;
        elseif alpha_sun < alpha_max(3)
            image(m-i,j) = 7;
        elseif alpha_sun < alpha_max(4)
            image(m-i,j) = 8;
        end
        
        %ANISOTROPIE SOLEIL
        A = M(1:2);  %projection de M dans le plan XY
        A = A ./ norm(A);
        phi = asin(A(1));  %angle de la normale (dans le plan XY) ~1e-3rad
        alpha_max = alpha_m(phi,d);
        
        %REFLET DE L'OBJET
        if (alpha_obj < alpha_max(1))
           image(m-i,j) = 11; 
        elseif (alpha_obj < alpha_max(2))
           image(m-i,j) = 12; 
        elseif (alpha_obj < alpha_max(3))
           image(m-i,j) = 13; 
        elseif (alpha_obj < alpha_max(4))
           image(m-i,j) = 14; 
        end
        
        %PRINT OBJET
        if norm(O .* norm(B) - B) < L %taille de l'objet
            O = O .* B(2)/O(2);
            if O(3) > -h %objet au dessus de l'eau
                image(m-i,j) = 9;   %objet
            end
        end
        
    end
    
    for i = m/2:m-1  %boucle verticale (ciel/objet)
        
        %VECTEUR D'OBSERVATION
        O = [(j-n/2-1)*l, f, (i-m/2-1)*l];
        O = O ./ norm(O);   %vecteur normalise d'observation
        
        %PRINT SOLEIL
        if norm(O + S) < 0.02
            image(m-i,j) = 3;   %soleil
        else
            image(m-i,j) = 2;   %ciel
        end
        
        %PRINT OBJECT
        if norm(O .* norm(B) - B) < L %taille de l'objet
           image(m-i,j) = 9;    %objet
        end
   end   
end