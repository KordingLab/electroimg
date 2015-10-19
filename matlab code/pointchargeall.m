function err = pointchargeall(x,j,rest,obs,Electrod_positions)
m = size(rest,2);
switch j
    case 1
        A = [x,rest(:,2:end)];
    case m
        A = [rest(:,1:end-1),x];
    otherwise
        A = [rest(:,1:j-1),x,rest(:,j+1:end)];
end
yest = evalpotential(Electrod_positions,A);
err = sum((yest-obs).^2);
%end