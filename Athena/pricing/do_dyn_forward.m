function Z=do_dyn_forward(G,R)

Z=[];
Z.sub=cell(G.NS,1);
Z.cost=zeros(G.NS,1);

for(s=1:G.NS)
    
    start_cost=R.start_cost(s);
    Z.cost(s)=start_cost;
    Z.sub{s}=[s];
    if(numel(G.dyn.pred{s})>0.5)
        %disp('in heer')
        cost2go=Z.cost(G.dyn.pred{s});
        cost2go=cost2go+R.sub_cost(s);
        [min_val,min_ind]=min(cost2go);
        min_ind=G.dyn.pred{s}(min_ind);
        if(min_val<start_cost)
            Z.cost(s)=min_val;
            Z.sub{s}=[Z.sub{min_ind},s];
            
        end
    end
end

Z.cost=Z.cost+R.end_cost;
inds_keep=find(Z.cost<-.0001);
Z.cost=Z.cost(inds_keep);
Z.sub=Z.sub(inds_keep);
