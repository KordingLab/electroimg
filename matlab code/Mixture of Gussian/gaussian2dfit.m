function [mode,cov] = gaussian2dfit(img)

[ny,nx] = size(img);
[px,py] = meshgrid(1:nx,1:ny);

options = optimset('lsqnonlin');
options.MaxFunEvals = 2000;
%options.Display = 'iter';
options.Display = 'off';

% % This is for fitting bias, mean, amplitude and covariance
% % starting values:
% % 1 - bias/ constant offset
% % 2 - mode_x
% % 3 - mode_y
% % 4 - amplitude
% % 5,6,7 - cholesky parameters for cov matrix
% 
% [mode0_y, mode0_x] = find(img == max(img(:)));
% params0 = [mean(img(:)),mode0_x,mode0_y,1,8,0,4];
% LB = [-inf,1,1,0,-inf,-inf-inf];
% UB = [inf,nx,ny,inf,inf,inf,inf];
% 
% params = lsqnonlin(@(P) gaussian2dfitobjfun(P,px,py,img),params0,LB,UB,options);
% %params = fmincon(@(P) gaussian2dfitobjfun(P,px,py,img),params0,[], [], [], [], LB,UB,[], options);
% 
% % Mode
% mode = [params(2), params(3)];
% % Covariance
% cov = [params(5),0;params(6),params(7)];
% cov = cov*cov';

%---------------------------------------
% % This is for fitting bias and covariance
% starting values:
% 1 - bias/ constant offset
% 2,3,4 - cholesky parameters for cov matrix

[mode0_y, mode0_x] = find(img == max(img(:)));
LB = [-inf,-inf,-inf-inf];
UB = [inf,inf,inf,inf];

% Initialize the covariance as the mode-centered weighted covariance matrix
% Below codeblock taken from weightedcov.m from MatlabFileExchange
% http://www.mathworks.com/matlabcentral/fileexchange/37184-weighted-covariance-matrix

w = img(:)/sum(img(:));
[T, N] = size([px(:) py(:)]);                                                     % T: number of observations; N: number of variables
C = [px(:) py(:)] - repmat([mode0_x(1), mode0_y(1)], T, 1);                       % Remove mode
C = C' * (C .* repmat(w, 1, N));                                                  % Weighted Covariance Matrix
C = 0.5 * (C + C');                                                               % Must be exactly symmetric
chol_L = chol(C, 'lower');

% Initialize
params0 = [mean(img(:)),chol_L(1,1),chol_L(2,1),chol_L(2,2)];

% Optimize
params = lsqnonlin(@(P) gaussian2dfitobjfun(P,px,py,mode0_x(1),mode0_y(1),img),params0,LB,UB,options);
%params = fmincon(@(P) gaussian2dfitobjfun(P,px,py,img),params0,[], [], [], [], LB,UB,[], options);

% Mode
mode = [mode0_x, mode0_y];

% Covariance
chol_L = [params(2),0;params(3),params(4)];
cov = chol_L*chol_L';

