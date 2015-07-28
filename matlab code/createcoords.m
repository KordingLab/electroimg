function [vol_coord, grid_coord, zcoord, dims] = createcoords(opts)

if nargin<1
    opts=[];
end

if isfield(opts,'xcoord')
    xcoord = opts.xcoord;
else
    xcoord = [-200:20:200]*10^-6;
end

   
if isfield(opts,'ycoord')
    ycoord = opts.ycoord;
else
    ycoord = [-300:20:200]*10^-6;
    
end

if isfield(opts,'zcoord')
    zcoord = opts.zcoord;
else
    zcoord = [-200:5:0]*10^-6;
end

if isfield(opts,'gridxcoord')
    gridxcoord = opts.gridxcoord;
else
    gridxcoord = [-200:10:200]*10^-6;
end

if isfield(opts,'gridycoord')
    gridycoord = opts.gridxcoord;
else
    gridycoord = [-300:10:200]*10^-6;
end

if isfield(opts,'gridxcoord')
    gridzcoord = opts.gridxcoord;
else
    gridzcoord = 0;
end

dims.vol_dims = [length(ycoord),length(xcoord)];
dims.grid_dims = [length(gridycoord),length(gridxcoord)];


vol_x = zeros(length(xcoord)*length(ycoord),length(zcoord));
vol_y = zeros(length(xcoord)*length(ycoord),length(zcoord));
vol_z = zeros(length(xcoord)*length(ycoord),length(zcoord));
for i=1:length(zcoord)
    [tmp1, tmp2, tmp3] = meshgrid(xcoord,ycoord,zcoord(i));
    vol_x(:,i) = reshape(tmp1,numel(tmp1),1);
    vol_y(:,i) = reshape(tmp2,numel(tmp1),1);
    vol_z(:,i) = reshape(tmp3,numel(tmp1),1);
end

vol_x = reshape(vol_x,numel(vol_x),1);
vol_y = reshape(vol_y,numel(vol_y),1);
vol_z = reshape(vol_z,numel(vol_z),1);

vol_coord = [vol_x vol_y vol_z];


[tmp1, tmp2, tmp3] = meshgrid(gridxcoord,gridycoord,gridzcoord);
grid_x = reshape(tmp1,numel(tmp1),1);
grid_y = reshape(tmp2,numel(tmp2),1);
grid_z = reshape(tmp3,numel(tmp3),1);

grid_coord = [grid_x grid_y grid_z];


end