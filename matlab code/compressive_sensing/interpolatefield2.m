function [Frec,whichsamp] = interpolatefield2(F0,numsamp,errtol)

N = numel(F0);
whichsamp = randi(N,round(numsamp*N),1);
ydata = F0(whichsamp);

stacksz = size(F0);
Frec = solveL1problem(ydata,whichsamp,stacksz,errtol);

end

function Frec = solveL1problem(ydata,whichsamp,stacksz,errtol)

for i=1:length(stacksz)
    Dict{i} = dctmtx(stacksz(i));
end

n1 = stacksz(1);
n2 = stacksz(2);
n3 = stacksz(3);
    
siz = stacksz;
    
cvx_begin
    cvx_precision low
    cvx_solver mosek
    
    variable Frec(n1,n2,n3)
    
    % regularize 
    for i=1:n3 
    	coef(:,:,i) =  Dict{1}*Frec(:,:,i)*Dict{2}';
    end
    
    for i=1:n3-1
        Diffs(:,:,i) = Frec(:,:,i)-Frec(:,:,i+1);
    end
       
    %coef = shiftdim(coef,2);
    %coef = Dict{3}'*reshape(coef,n3,[]);
    
    %errs = 1/numel(Frec)*sum(sum((ydata - Frec(whichsamp)).^2));
    %errs = (ydata - Frec(whichsamp)).^2;
    minimize(norm(coef(:),1) + norm(Diffs(:),1))
    subject to
    %errs<=errtol
    ydata == Frec(whichsamp)
cvx_end


end


