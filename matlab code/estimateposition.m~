function [xout,fval] = estimateposition(y,k,lambda,numiter)

if nargin<3
   numiter = 1;
   lambda = 0; 
end

if nargin<4
    numiter=1;
end

[~,grid_coord] = createcoords([]);

warning off; 
fval = zeros(numiter,1);
for i=1:numiter
    x0 = [randn(k,3)*10^-8, randn(k,1)]; 
    fx = @(x)myfun2(x,y,grid_coord,k,lambda);
    [xnew,fval(i)] = fminunc(fx,x0);
    
    %xout{i} = [xnew(:,1:3).*repmat(xnew(:,4),1,3), 1./xnew(:,4)];
    xout{i} = xnew;
end
    
end

function fx = myfun(x,y,grid_coord,k,lambda)

n = length(y); 

fx = 0;
for j=1:k
for i=1:n
    fx = fx + (y(i) - 1./norm( grid_coord(i,:)*x(j,4) - x(j,1:3)))^2; 
end
end

% enforce constraint that transmembrane currents must sum to 0
fx = fx + lambda*sum(1./x(:,4)); 

end

function fx = myfun2(x,y,grid_coord,k,lambda)

n = length(y); 

fx = 0;
for j=1:k
for i=1:n
    fx = fx + (y(i) - x(j,4)./norm(grid_coord(i,:)-x(j,1:3))).^2; 
end
end

% enforce constraint that transmembrane currents must sum to 0
fx = fx + lambda*sum(x(:,4)); 

end