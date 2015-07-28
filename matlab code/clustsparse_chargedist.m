function [supp,coef,yrec] = clustsparse_chargedist(y,vol_coord,grid_coord,normtol,kmax)
sigma = 50000;

N = length(vol_coord); 

if nargin<5
    kmax=N/2;
end

resid = y./norm(y);

T = buildTmatrix(vol_coord,grid_coord,sigma);
for i=1:N
     T(:,i) = T(:,i)./norm(T(:,i));
end

Aty = T'*resid;
[~,id] = max(abs(Aty));

[Told,newidx] = buildclustdict(id,vol_coord,grid_coord,sigma);

supp = id;
coef = pinv(T(:,id))*y;
yrec = T(:,id)*coef;
resid = y - yrec;

while norm(resid)>normtol

    Aty = Told'*resid;
    [~,id] = max(abs(Aty));
    id2 = newidx(id);
    [Told,newidx] = buildclustdict(supp,vol_coord,grid_coord,sigma);
    supp = [supp,id2];
    
    coef = pinv(T(:,supp))*y;
    yrec = T(:,supp)*coef;
    resid = y - yrec;
    
    if length(supp)==kmax
        return
    end
end

end

function [T,newidx] = buildclustdict(supp,vol_coord,grid_coord,sigma)

newidx=[];
for i=1:length(supp)
    xydim = [ length(unique(vol_coord(:,2))), length(unique(vol_coord(:,1))), length(unique(vol_coord(:,3)))];
    [xx,yy] = ind2sub(xydim,supp(i));

    [XX,YY] = meshgrid(max(1,xx-1):min(xx+1,xydim(1)),max(1,yy-1):min(yy+1,xydim(2)));
    newidx = [newidx; sub2ind(xydim,XX(:),YY(:))];
    newidx(newidx==supp(i))=[];    
end

T = buildTmatrix(vol_coord(newidx,:),grid_coord,sigma);

for i=1:size(T,2)
     T(:,i) = T(:,i)./norm(T(:,i));
end

end

