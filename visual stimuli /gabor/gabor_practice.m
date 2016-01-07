%%to multiply the size of a grating by x, multiply lambda and sigma by x


[x y F] = gabor('lambda',40,'sigma',20,'px',.5,'py',.5,'theta',45);
[x y F] = gabor('lambda',20,'sigma',10,'px',.5,'py',.5,'theta',45);

index = 0;
F = zeros(256,256,length(0:5:360));
for theta = 0:5:360
    index = index + 1;
    [x y F(:,:,index)] = gabor('lambda',40,'sigma',20,'px',.5,'py',.5,'theta',theta);
end

figure
index = 0;
for theta = 0:5:360
    index = index + 1;
    pcolor(x,y,F(:,:,index)); 
    axis image;
    shading('interp'); 
    colormap gray;
end

figure
[x y F] = gabor('lambda',20,'sigma',10,'px',.5,'py',.5,'theta',45);
pcolor(x,y,F);
axis image;
shading('flat')
colormap gray;


figure
[x y F] = gabor('lambda',20,'sigma',10,'px',.5,'py',.5,'theta',45);
pcolor(x,y,F);
axis image;
shading('interp')
colormap gray;
