function coef = dctndim(A)

siz = size(A);

for i=1:length(siz)
    Dict{i} = dctmtx(siz(i));
end

for i=1:3 
    coef = reshape(Dict{i}'*reshape(A,siz(1),[]),siz); 
    siz= [siz(2:end) siz(1)]; 
    coef = shiftdim(coef,1); 
end
        
end