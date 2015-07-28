% script to invert potentials to recover charge distribution

addpath('/home/edk422/electricalimaging/matlabcode')
addpath('/home/edk422/electricalimaging/matlabcode/matfiles')

load Data_2a_3b
y1 = X(:,100);
y2 = X(:,2827+99);

correct_z = 100*10^-6;
sigma = 0.3;
%dims = [51,41];


%% define grid and volume coordinates

% default values
% xcoord = [-200:10:200]*10^-6;
% ycoord = [-200:10:200]*10^-6;
% zcoord = [-300:10:300]*10^-6;
% gridxcoord = [-200:10:200]*10^-6;
% gridycoord = [-300:10:200]*10^-6;
% gridzcoord = 0;

[vol_coord, grid_coord, zcoord, dims] = createcoords();


%% generate field from synthetic charge distribution

% charge3d = zeros(length(xcoord),length(ycoord),length(zcoord)); 
% charge3d(1:5,1:10,1)=randn(5,10,1);
% c0 = reshape(charge3d,numel(charge3d),1);
% 
% c0 = zeros(23001,1); c0(1:5)= 1;
% 
% dict_fun = @(x,mode) fieldtocharge(x,mode,...
%     [vol_x,vol_y,vol_z],[grid_x,grid_y,grid_z],sigma);
% 
% p0 = dict_fun(c0,1);

% correct_z = unique(zcoord(ceil(find(c0)./(length(grid_x)))));


%% compute LS estimates for each z plane

%matlabpool 8
[LS_est,LS_recs,LS_errs] = partial_LSestimates(y1./norm(y1),vol_coord,...
    grid_coord,zcoord,sigma,dims,0);

save results_nov_6



%% compute LS estimate from entire dictionary 

% dict_fun = @(x,mode) fieldtocharge(x,mode,...
% [vol_x,vol_y,vol_z],[grid_x,grid_y,grid_z]);
% ls_fullD = dict_fun(p0,3);
% 
% figure; 
% % plot partial LS estimates
% for i=1:length(zcoord) 
%     subplot(ceil(length(zcoord)/5),5,i); 
%     imagesc(reshape(ls_fullD((i-1)*2091+1:i*2091),51,41)); 
%     
%     %ell0_energy = norm(ls_est(:,i),1);
%     plot_title = ['Depth = ', int2str(zcoord(i))];
%     
%     if zcoord(i)==correct_z
%         plot_title = [plot_title, ' (Correct Plane)'];
%     end
%     title(plot_title) 
% end
% 
% 
% %% L1 recovery
% % use partial dictionary for reconstruction
% 
% for i=1:length(zcoord)
%     options.iterations=100;
%     dict_part = @(x,mode) fieldtocharge(x,mode,...
%         [vol_x,vol_y,vol_z],[grid_x,grid_y,grid_z],zcoord(i));
%     c_hat(:,i) = spg_bp(dict_part,p0);
% end
% 
% 









