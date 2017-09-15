function Z=do_dyn_forward(G,R)

Z=[];
Z.sub=cell(G.n_sub,1);
Z.cost=zeros(G.n_sub,1);



Z.cost=Z.cost+R.end_cost;
inds_keep=find(Z.cost>=0);
Z.cost=Z.cost(inds_keep);
Z.sub=Z.sub{inds_keep};