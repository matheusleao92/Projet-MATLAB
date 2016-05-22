function [LUT] = LUT_colors(t)
%LUT_colors

c_sun = [255,255,0]./255;
c_sky = [135,206,235]./255;
c_sea = [0,102,204]./255;
c_refl1 = [222, 246, 255]./255;
c_refl2 = [192,237,255]./255;
c_refl3 = [142,222,255]./255;
c_refl4 = [80,205,255]./255;
c_sea2 = [0, 110, 234 ]./255;
c_obj = [0,255,0]./255;
c_reflobj = [0,255,200]./255;

%sky colors
%r = abs(-0.0072*t^3 + 0.3727*t^2 - 6.1846*t + 33.0196);
%g = abs(-0.0005*t^3 + 0.0224*t^2 - 0.3136*t + 1.9490);
%b = abs(0.0052*t^3 - 0.2766*t^2 + 4.6371*t - 24.0980);

%c_sky = [r,g,b];

LUT = [c_sea; c_sky; c_sun; c_sea2; c_refl1; c_refl2; c_refl3; c_refl4; c_obj; c_reflobj];