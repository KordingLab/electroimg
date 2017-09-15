function out_mat=con_Theta(G,Z)

out_mat=zeros(numel(Z.cost),1);

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};

    cost=G.start_cost(sub_in(1));
    cost=cost+sum(G.sub_cost(sub_in));
    out_mat(z)=cost;
end 