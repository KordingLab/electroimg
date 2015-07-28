function [y,Tinv,T] = fieldtocharge(x,mode,vol_coord,grid_coord,sigma,varargin)
% pass in additional argument that specifies the depth at which you wish to
% reconstruct the charge distribution

Tinv=0;
conduct_const = 1/(4*pi*sigma);

if nargin>5
    idx = vol_coord(:,3)==varargin{1};
    
    if sum(idx)==0
        error('No coordinates specified at this partial depth!')
    end
    vol_coord = vol_coord(idx,:);
end
        
Nvol = size(vol_coord,1);
Ngrid = size(grid_coord,1);



%if strcmp(method,'partial')

    if mode==1 % compute y = T*c  (potential from charge)

          T = buildTmatrix(vol_coord,grid_coord,sigma);
          supp = find(abs(x)>1e-8);
          y = T(:,supp)*x(supp);


    elseif mode==2 % compute y = T'*p  (charge from potential)

        supp = 1:Ngrid;
        xsupp = x;
        
        y = zeros(Nvol,1);
    
        for j = 1:Nvol
            rowvec = conduct_const*(1./sqrt(1e-7 + sum((repmat(vol_coord(j,:),length(supp),1) - grid_coord(supp,:)).^2,2)));        
            y(j) = rowvec'*xsupp;
        end
        
    elseif mode==3
        % find LS-estimate
                
        Tmat = zeros(Ngrid,Nvol);
        for j = 1:Ngrid
            Tmat(j,:) = conduct_const*(1./sqrt(1e-7 + sum(( vol_coord - repmat(grid_coord(j,:),Nvol,1)).^2,2)));        
        end
        
        Tinv = pinv(Tmat);
        y = Tinv*x;
        
    end
    

end% end function


