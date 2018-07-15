function parent = parent_index(Ebar)

[x_g,y_g] = find(Ebar~=0);
parent = zeros(length(Ebar),1);
parent(x_g) = y_g;
parent(1)=1;