function [Frec,whichsamp] = interpolatefield(F0,numsamp,errtol)

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

if length(Dict)==2
    n1 = stacksz(1);
    n2 = stacksz(2);

    cvx_begin
        cvx_precision low
        cvx_solver mosek
    
        variable Frec(n1,n2)
        coef = Dict{1}*Frec*Dict{2}';
        errs = (ydata - Frec(whichsamp)).^2;
        %errs = 1/numel(Frec)*sum(sum((ydata - Frec(whichsamp)).^2));
        minimize(norm(coef(:),1))
        subject to
        errs<=errtol
        %ydata == Frec(whichsamp)
    cvx_end

elseif length(Dict)==3
    
    n1 = stacksz(1);
    n2 = stacksz(2);
    n3 = stacksz(3);
    
    siz = stacksz;
    
    %for i=1:n3 
    %    RBF(:,i) = exp(-(([1:n3] - i).^2./60)); 
    %end
    
    cvx_begin
        cvx_precision low
        cvx_solver mosek
    
        variable Frec(n1,n2,n3)
        
        % compute multidimensional DCT
        %for i=1:3 
        %    coef = reshape(Dict{i}'*reshape(Frec,siz(1),[]),siz); 
        %    siz= [siz(2:end) siz(1)]; 
        %    coef = shiftdim(coef,1); 
        %end
        
        coef = Frec;
        for i=1:3 
            coef = reshape(Dict{i}'*reshape(coef,siz(1),[]),siz); 
            siz= [siz(2:end) siz(1)]; 
            coef = shiftdim(coef,1); 
        end
        
        %coef = RBF'*coef;
        
        %errs = 1/numel(Frec)*sum(sum((ydata - Frec(whichsamp)).^2));
        errs = (ydata - Frec(whichsamp)).^2;
        minimize(norm(coef(:),1))
        subject to
        errs<=errtol
        %ydata == Frec(whichsamp)
    cvx_end

elseif length(Dict)==4
    
    n1 = stacksz(1);
    n2 = stacksz(2);
    n3 = stacksz(3);
    n4 = stacksz(4);
    
    siz = stacksz;
    cvx_begin
        cvx_solver mosek
    
        variable Frec(n1,n2,n3,n4)
        
        % compute multidimensional DCT
        for i=1:4 
            coef = reshape(Dict{i}'*reshape(Frec,siz(1),[]),siz); 
            siz= [siz(2:end) siz(1)]; 
            coef = shiftdim(coef,1); 
        end
        %errs = 1/numel(Frec)*sum(sum((ydata - Frec(whichsamp)).^2));
        %errs = (ydata - Frec(whichsamp)).^2;
        minimize(norm(coef(:),1))
        subject to
        %errs<=errtol
        ydata == Frec(whichsamp)
    cvx_end
    
end


end


