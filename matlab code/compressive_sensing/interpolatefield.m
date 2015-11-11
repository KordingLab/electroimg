function [Frec,whichsamp] = interpolatefield(F0,numsamp,lambda)

[n1,n2] = size(F0);
N = n1*n2;
whichsamp = randi(N,round(numsamp*N),1);

Dr = dctmtx(n1);
Dc = dctmtx(n2);

ydata = F0(whichsamp);
cvx_precision low

cvx_begin
   variable Frec(n1,n2)
   coef = Dr*Frec*Dc';
   errs = sum(sum((ydata - Frec(whichsamp)).^2));
   minimize( errs +lambda*norm(coef(:),1) )
cvx_end


end


