function out_mat=con_Theta(G,Z)

out_mat=zeros(numel(Z.cost),1);

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};

    cost=G.C.start_cost(sub_in(1));
    cost=cost+sum(G.C.cost(sub_in));
    cost=cost+G.C.term_cost(sub_in(end));
    out_mat(z)=cost;
end 