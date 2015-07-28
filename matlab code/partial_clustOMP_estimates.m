function [Supp,Coef,Yrec,Errs,L0norm,Depth] = partial_clustOMP_estimates(y,normtol,kmax,visualize)

if nargin<3
    kmax = 1000;
    visualize =1;
end

if nargin<4
    visualize=1;
end

[vol_coord, grid_coord, zcoord,dims] = createcoords([]);

Yrec = zeros(size(grid_coord,1),length(zcoord));
Errs = zeros(length(zcoord),1);
L0norm = zeros(length(zcoord),1);
for i=1:length(zcoord)
    whichz = zcoord(i);
    id = find(vol_coord(:,3)==whichz);

    vcoord2 = vol_coord(id,:);
    [Supp{i},Coef{i},Yrec(:,i)] = clustsparse_chargedist(y,vcoord2,...
        grid_coord+randn(size(grid_coord))*0.5*10^-6,normtol,kmax);
    
    Errs(i) = norm( y./norm(y) - Yrec(:,i)./norm(Yrec(:,i)));
    L0norm(i) = length(Supp{i});
    Depth(i) = vol_coord(id(1),3);
end

% plot results

if visualize==1
figure;
imagesc(reshape(y,dims.grid_dims(1),dims.grid_dims(2)))
title('Observed Field')

figure;
count=0;
for i=1:2:30 
    count=count+1;
    subplot(3,15,count); 
    imagesc(reshape(Yrec(:,i),dims.grid_dims(1),dims.grid_dims(2))); 
    title(['Depth = ', num2str(zcoord(i)*10^6,3)])
end

for i=1:2:30 
    count=count+1;
    subplot(3,15,count); 
    imagesc(reshape(y - Yrec(:,i),51,41));
    title(['Error = ', num2str(Errs(i),3)])
end

for i=1:2:30
    count=count+1;
    subplot(3,15,count);
    cvec = zeros(dims.vol_dims(1)*dims.vol_dims(2),1); 
    cvec(Supp{i}) = Coef{i};
    imagesc(reshape(cvec,dims.vol_dims(1),dims.vol_dims(2))); 
    title(['Sparsity = ', num2str(L0norm(i),3)])
end

end


end