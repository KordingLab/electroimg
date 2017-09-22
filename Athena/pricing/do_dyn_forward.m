function Z=do_dyn_forward(G,R)

Z=[];
Z.sub=cell(G.NS,1);
Z.cost=zeros(G.NS,1);
Z.start_at_sub_1=zeros(G.NS,1);
Z.origin=zeros(G.NS,1);
for(s=1:G.NS)
    
    start_cost=R.start_cost(s);
    Z.cost(s)=start_cost;
    Z.sub{s}=[s];
    Z.start_at_sub_1(s)=(s==1);

    if(numel(G.dyn.pred{s})>0.5)
        %disp('in heer')
        cost2go=Z.cost(G.dyn.pred{s});
        cost2go=cost2go+R.sub_cost(s);
        [min_val,min_ind]=min(cost2go);
        min_ind=G.dyn.pred{s}(min_ind);
        if(min_val<start_cost)
            Z.cost(s)=min_val;
            Z.sub{s}=[Z.sub{min_ind},s];
            Z.start_at_sub_1(s)=Z.start_at_sub_1(min_ind);
        end
    end
end

Z.cost=Z.cost+R.end_cost;
inds_keep=find(Z.cost<-.0001);
Z.cost=Z.cost(inds_keep);
Z.sub=Z.sub(inds_keep);
Z.start_at_sub_1=Z.start_at_sub_1(inds_keep);
hold=min(Z.start_at_sub_1.*Z.cost);
%jy_out_val('hold',hold)
%jy_out_val('Z.cost(1)',Z.cost(1))
%pause

