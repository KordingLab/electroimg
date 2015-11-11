function [Frec,whichsamp,Err] = interpolatefield(F0,numsamp,errtol)

N = numel(F0);
whichsamp = randi(N,round(numsamp*N),1);
ydata = F0(whichsamp);

stacksz = size(F0);
Frec = solveL1problem(ydata,whichsamp,stacksz,errtol);
Err = norm(Frec(:)-F0(:))./norm(F0(:));

end

function Frec = solveL1problem(ydata,whichsamp,stacksz,errtol)

for i=1:length(stacksz)
    Dict{i} = dctmtx(stacksz(i));
end

cvx_precision best

if length(Dict)==2
    n1 = stacksz(1);
    n2 = stacksz(2);

    cvx_begin
    
        cvx_solver mosek
    
        variable Frec(n1,n2)
        coef = Dict{1}*Frec*Dict{2}';
        errs = (ydata - Frec(whichsamp)).^2;
        minimize(norm(coef(:),1))
        subject to
        errs<errtol
    cvx_end

elseif length(Dict)==3
    
    n1 = stacksz(1);
    n2 = stacksz(2);
    n3 = stacksz(3);
    
    siz = stacksz;

    cvx_begin
        cvx_solver mosek
    
        variable Frec(n1,n2,n3)
        
        % compute multidimensional DCT
        for i=1:3 
            coef = reshape(Dict{i}'*reshape(Frec,siz(1),[]),siz); 
            siz= [siz(2:end) siz(1)]; 
            coef = shiftdim(coef,1); 
        end
    
        errs = (ydata - Frec(whichsamp)).^2;
        minimize(norm(coef(:),1))
        subject to
        errs<errtol
    cvx_end
    
end


end

