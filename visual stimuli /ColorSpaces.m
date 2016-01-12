%The goal is to map out a space like in Boehm et. al 2014

%Let's try to go from MB coordinates (as in the figure in Boehm et al,
%2014) to RGB coordinates so I can plot a 2D map as shown there. 

load phosphors
load fundamentals_ss

luminance = 1;

%MB1 is the r-coordinate
incMB1 = .005;
MB1 = .67:incMB1:.73;

%MB2 is the b-coordinate
incMB2 = .1;
MB2 = .2:incMB1:1.8;

count1 = 0;
count2 = 0;

figure
hold on
for r = MB1
    count1 = count1 + 1;
    for b = MB2
      count2 = count2 + 1;
      rgbMB = [r 1-r b];
      [lms] = rgbMB2lms(rgbMB,luminance);
      [RGB] = lms2rgb(phosphors,fundamentals,lms);
      rgbScaled = RGB./255
      rgbCorrected = max(min(1,rgbScaled),0)
      fill([r, r ,r+ incMB1,r + incMB1],[b, b + incMB2,b + incMB2, b ], rgbCorrected)

    end
end
hold off

%%
%Random color plot
inc = .1; %increment
x0 = 0;
xF = 1;
y0 = 0;
yF = 1;


figure
hold on
for x=x0:inc:xF
    for y=y0:inc:yF
        color = [rand rand rand];
        fill([x, x ,x+ inc,x + inc],[y, y + inc,y + inc, y ], color)
     
    end
end
hold off


