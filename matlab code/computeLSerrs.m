function [Errs,Recs] = computeLSerrs(p0,LSest,vol_coord,grid_coord,zcoord,sigma)
% vol_dims = pass in dims of charge universe

Errs = zeros(length(zcoord),1);
nmp = norm(p0);

for i=1:length(zcoord); 
    dict_fun = @(x,mode) fieldtocharge(x,mode,...
        vol_coord,grid_coord,sigma,zcoord(i));
        
    Recs(:,i) = dict_fun(LSest(:,i),1);
    Errs(i) = norm( Recs(:,i) - p0)./nmp;
end

end