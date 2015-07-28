function [LSest,Recs,Errs] = partial_LSestimates(p0,visualize)

sigma = 50000;
% vol_dims = pass in dims of charge universe

%vol_dims = dims.vol_dims;
%grid_dims = dims.grid_dims;


if nargin<2
    visualize =1;
end

[volcoord, gridcoord, zcoord,dims] = createcoords([]);

Nvol = sum(volcoord(:,3)==zcoord(1));
LSest = zeros(Nvol,length(zcoord));
Errs = zeros(length(zcoord),1);

nmp = norm(p0);

for i=1:length(zcoord)
    dict_fun = @(x,mode) fieldtocharge(x,mode,...
        volcoord,gridcoord,sigma,zcoord(i));
        LSest(:,i) =dict_fun(p0,3); 
        
        Recs(:,i) = dict_fun(LSest(:,i),1);
        Errs(i) = norm( Recs(:,i)  - p0)./nmp;
        
        
        if visualize==1
            figure(1)
            subplot(ceil(length(zcoord)/10),10,i); 
            imagesc(reshape(LSest(:,i),dims.vol_dims(1),dims.vol_dims(2))); axis square
            title(num2str(zcoord(i)))
        
            figure(2)
            subplot(ceil(length(zcoord)/10),10,i); 
            imagesc(reshape(Recs(:,i),dims.grid_dims(1),dims.grid_dims(2))); axis square
            title(num2str(zcoord(i)))
            
        end
end


if nargin>5
    plot_partialLS(LSest,vol_dims,zcoord,1)
end

end