% ==============================
% % Objective function for fitting bias, mean, amplitude and covariance
% function resids = gaussian2dfitobjfun(params,px,py,img)
% covchol = [params(5),0;params(6),params(7)];
% temp = [px(:) - params(2),py(:)-params(3)]*covchol;
% pred = params(1) + params(4)*exp(-sum(temp.*temp,2)/2);
% 
% resids = pred - img(:);
% %resids = mean((pred - img(:)).^2);


% Objective function for fitting bias and covariance (fixed mean and
% amplitude)
function resids = gaussian2dfitobjfun(params, px, py, mode_x, mode_y, img)
covchol = [params(2),0;params(3),params(4)];
temp = [px(:) - mode_x, py(:) - mode_y]*covchol;
pred = params(1) + exp(-sum(temp.*temp,2)/2);

resids = pred - img(:);
%resids = mean((pred - img(:)).^2);
