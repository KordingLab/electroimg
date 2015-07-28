function T = buildTmatrix(vol_coord,grid_coord,sigma)

Ngrid = size(grid_coord,1);
Nvol = size(vol_coord,1);

conduct_const = 1/(4*pi*sigma);

T = zeros(Ngrid,Nvol);
for i=1:Ngrid
    T(i,:) = conduct_const*(1./(1e-7 + sqrt(sum((vol_coord - repmat(grid_coord(i,:),Nvol,1)).^2,2)))); 
    
    % option 1 for dealing with zero distances
    %[~,id] = max(T(i,:)); T(i,id)=0;
    %[~,id2] = max(T(i,:)); T(i,id) = T(i,id2);
    
end



end %end function