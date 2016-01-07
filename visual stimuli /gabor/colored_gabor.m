function [x y F] = colored_gabor(varargin)    

    % Parse Input
    p = inputParser;
    
    %Default values
    defaultTheta = 2*pi*rand;
    defaultLambda = 20;
    defaultSigma = 10;
    defaultWidth = 256;
    defaultHeight = 256;
    defaultPx = rand*0.8 + 0.1;
    defaultPy = rand*0.8 + 0.1;
    
    %Add input parameters
    addParameter(p,'theta',defaultTheta,@isnumeric);
    addParameter(p,'lambda',defaultLambda,@isnumeric);
    addParameter(p,'Sigma',defaultSigma,@isnumeric);
    addParameter(p,'width',defaultWidth,@isnumeric);
    addParameter(p,'height',defaultHeight,@isnumeric);
    addParameter(p,'px',defaultPx,@isnumeric);
    addParameter(p,'py',defaultPy,@isnumeric);
    p.KeepUnmatched = true;
    parse(p,varargin{:});

    % Generate mesh
    [x y] = meshgrid(1:p.Results.width, 1:p.Results.height);

    % Center of gaussian window
    cx = p.Results.px*p.Results.width;
    cy = p.Results.py*p.Results.height;

    % Orientation
    x_theta=(x-cx)*cos(p.Results.theta)+(y-cy)*sin(p.Results.theta);
    y_theta=-(x-cx)*sin(p.Results.theta)+(y-cy)*cos(p.Results.theta);

    % Generate gabor
    F = exp(-.5*(x_theta.^2/p.Results.Sigma^2+y_theta.^2/p.Results.Sigma^2)).*cos(2*pi/p.Results.lambda*x_theta);
    
end