function err = pointchargefn(x,obs,Electrod_positions)
% yobs = observed field (Nx1)
% grid_pos = 3xN (pos of electrodes)
% xest = estimate of charges

% if nargin<3
%     [xx,yy,zz] = meshgrid([-1:0.05:1],[-1:0.05:1],[-1:0.05:1]);
%     grid_pos = [xx(:),yy(:),zz(:)]';
%     yobs = evalpotential(grid_pos,x0);
% end
m = size(x,1)/4;
yest = evalpotential(Electrod_positions,reshape(x,4,m));
err = norm(yest-obs);
end