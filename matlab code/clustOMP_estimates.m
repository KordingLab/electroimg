function [Supp,Coef,Yrec,Errs,L0norm] = clustOMP_estimates(y,normtol,kmax)

[vol_coord, grid_coord, ~,~] = createcoords([]);

% need to modify to work in 3D
[Supp,Coef,Yrec] = clustsparse_chargedist(y,vol_coord,grid_coord,normtol,kmax);
Errs = norm( y./norm(y) - Yrec./norm(Yrec));
L0norm = length(Supp);

end