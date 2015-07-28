function [supp,coef,yrec] = sparse_chargedist(y,vol_coord,grid_coord,normtol,kmax)
sigma = 50000;

N = length(vol_coord); 

if nargin<5
    kmax=N/2;
end

%dict_fun = @(x,mode) fieldtocharge(x,mode,...
%        vol_coord,grid_coord,sigma);

T = buildTmatrix(vol_coord,grid_coord,sigma);

for i=1:N
     T(:,i) = T(:,i)./norm(T(:,i));
end

resid = y./norm(y);
%normtol = 0.1;
supp = [];

while norm(resid)>normtol
    Aty = T'*resid;
    [~,id] = max(abs(Aty));
    supp = [supp, id];
    coef = pinv(T(:,supp))*y;
    
    yrec = T(:,supp)*coef;
    resid = y - yrec;
    
    if length(supp)==kmax
        return
    end
end

% out = vol_coord(id,:);
% 
% figure; 
% for i=1:numz; 
%     subplot(5,5,i); 
%     imagesc(reshape(Atp0((i-1)*N +1:i*N), ...
%         dims.vol_dims(1),dims.vol_dims(2)),[min(Atp0),max(Atp0)]); 
% end


end