n = 32; %mm (largeur)
m = 24; %mm (hauteur)
l = 0.05; %mm
f = 50; %mm
h = 5; %mm?
E = 5; %deg
B = [10, 300, -5]; %mm?

figure;

[img, c] = sunset(n,m,l,f,h,E,B);
imshow(img, c)