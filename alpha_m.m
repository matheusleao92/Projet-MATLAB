function [alpha] = alpha_m(phi, d)
% Alpha_m : Anisotropie du problème, donne la normale maximale de la superficie pour chaque angle d'incidence phi.
% USAGE : am = alpha_m(phi)
%	phi : angle d'incidence (dans le plan XY)
%   d : distance de la mer
%	alpha_m : angle maximum de la normale

a = 2 *pi/180;
b = 5 *pi/180;
c = 10 *pi/180;

a = tan(a);
b = tan(b);
phi = phi - c;

%alpha(1) = 5*pi/180;

alpha(1) = atan(a*b/sqrt((a*cos(phi))^2 + (b*sin(phi))^2));

alpha(2) = 1.1*alpha(1);
alpha(3) = 1.1*alpha(2);
alpha(4) = 1.1*alpha(3);