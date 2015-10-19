function a = NextVector(Xstart,obs,Electrod_positions,options)
m = size(Xstart,2);
for i = 1:m
    switch i
        case 1
            A = Xstart(:,2:end);
        case m
            A = Xstart(:,1:end-1);
        otherwise
            A = [Xstart(:,1:i-1),Xstart(:,i+1:end)];
    end
    fx = @(x)pointchargeall(x,i,A,obs,Electrod_positions);
    x = fminunc(fx,Xstart(:,i),options);
    a(:,i) = x;
end