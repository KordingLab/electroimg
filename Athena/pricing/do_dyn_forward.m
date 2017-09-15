function Z=do_dyn_forward(G,R)

Z=[];
Z.sub=cell(G.n_sub,1);
Z.cost=zeros(G.n_sub,1);

for(s=1:G.n_sub)
    
    start_cost=R.start_cost;
    Z.cost=start_cost;
    Z.sub{s}=[s];
    if(numel(G.pred{s})>0.5)

        cost2go=Z.cost(G.pred{s});
        cost2go=cost2go+R.theta_sub(s);
        [min_val,min_ind]=min(cost2go);
        min_ind=G.pred{s}(min_ind);
        if(min_val<start_cost)
            Z.cost(s)=min_val;
            Z.sub{s}=[Z.sub{s},s];
        end
    end
end

Z.cost=Z.cost+R.end_cost;
inds_keep=find(Z.cost>=0);
Z.cost=Z.cost(inds_keep);
Z.sub=Z.sub{inds_keep};

