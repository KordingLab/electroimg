function new_parent = cc_par(parent)
% Finding connected components of parent id

ind = find(parent~=0);
new_parent = zeros(length(parent),1);
for i=1:length(ind)
    j = ind(i);
    while(j>1)
    j = parent(j);
    end
    if j==1
        new_parent(ind(i)) = parent(ind(i));
    end
end