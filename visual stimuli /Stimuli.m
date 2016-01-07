%%Author: Nick Blauch
%%Updated 1/7/2016


%experimental conditions
view_dist_mm = 500; %mm
visanglex = 1; 
visangley = 1;
totdist = view_dist_mm;
screenwidth = 290; %mm
screenres = 2560; %pixels, x-direction

%To create an image which is 20 deg X 20 deg 
box_size_ang = 20;
[box_size_xdist, boxsize_ydist] = visangle2stimsize(box_size_ang,box_size_ang,totdist,screenwidth,screenres);
%1583 pixels -- good imSize for now. Round to 1582 for an even division

imSize = 1582;
lambda_vis_ang = 1; %deg/cycle

[sizex,sizey] = visangle2stimsize(visanglex,visangley,totdist,screenwidth,screenres);

lambda = sizex; %spatial wavelength
amp = 1; %amplitude
sigma = 10000; %decay constant for gaussian envelope. very large for no envelope.
phase = 0; %phase
show = 0; %display image
prp = 0;
theta = 25; %orientation angle


%-------------------------------------------------------------------------%
%Step 1 -- create a greyscale gabor
%-------------------------------------------------------------------------%

gabor = Gabor_function( imSize, lambda, amp, theta, sigma, phase, show, prp);

%%colormap gray(256); % use gray colormap (0: black, 1: white)
%%imagesc( gabor, [-1 1] ); % display

%-------------------------------------------------------------------------%
%%Step 2 -- create an annular aperture
%-------------------------------------------------------------------------%

inner_r_ang = .5; % deg
inner_r_pix = visangle2stimsize(inner_r_ang,inner_r_ang,totdist,screenwidth,screenres);
outer_r_ang = 8; %deg
outer_r_pix = visangle2stimsize(outer_r_ang,outer_r_ang,totdist,screenwidth,screenres);
origin_r = 791; %pix
[rr cc] = meshgrid(1:imSize);
annulus = (sqrt((rr-origin_r).^2+(cc-origin_r).^2)) <= inner_r_pix |(sqrt((rr-origin_r).^2+(cc-origin_r).^2)) >=outer_r_pix;
%%Set annulus values of 1 to background
for index1=1:imSize
    for index2=1:imSize
        if(annulus(index1,index2)==1)
            gabor(index1,index2) = 0;
        end
    end
end

%-------------------------------------------------------------------------%
%Optional step 2.5: Make the grating a square wave
%-------------------------------------------------------------------------%
for index1=1:imSize
    for index2=1:imSize
        if(gabor(index1,index2)>0)
            gabor(index1,index2) = 1;
        end
        if(gabor(index1,index2)<0)
            gabor(index1,index2) = -1;
        end
    end
end

%-------------------------------------------------------------------------%
%Step 3 -- color region 1 according to specs
%-------------------------------------------------------------------------%

Regions = gabor>0; %%White is 1, black is 0 logical


%-------------------------------------------------------------------------%
%Step 4 -- display stimulus
%-------------------------------------------------------------------------%

colormap gray(256); % use gray colormap (0: black, 1: white)
imagesc( gabor, [-1 1] ); % display



