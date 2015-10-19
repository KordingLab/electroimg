function x = NextVectorUpdateSim(Xstart,obs,Electrod_positions,options)
m = size(Xstart,2);
x = [];
for i = 1:m
    switch i
        case 1
            A = Xstart(:,2:end);
        case m
            A = x;
        otherwise
            A = [x(:,1:i-1),Xstart(:,i+1:end)];
    end
    fx = @(x)pointchargeall(x,i,A,obs,Electrod_positions);
    y = fminunc(fx,Xstart(:,i),options);
    x(:,i) = y;
end