function err = pointchargefn2(x,x1,obs,Electrod_positions)
% yobs = observed field (Nx1)
% grid_pos = 3xN (pos of electrodes)
% xest = estimate of charges

% if nargin<3
%     [xx,yy,zz] = meshgrid([-1:0.05:1],[-1:0.05:1],[-1:0.05:1]);
%     grid_pos = [xx(:),yy(:),zz(:)]';
%     yobs = evalpotential(grid_pos,x0);
% end
yest = evalpotential(Electrod_positions,[x1,x]);
err = norm(yest-obs);
end