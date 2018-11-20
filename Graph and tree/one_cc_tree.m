function new_par = one_cc_tree(parent)
ind = find(parent~=0);
new_par = zeros(length(parent),1);
for i=1:length(ind)
    j = ind(i);
    while(j>1)
    j = parent(j);
    end
    if j==1
        new_par(ind(i)) = parent(ind(i));
    end
end