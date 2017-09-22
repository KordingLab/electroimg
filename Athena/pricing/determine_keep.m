function     Z=determine_keep(G,Z)

start_cost= zeros(G.N,1);
start_ind = zeros(G.N,1);

end_cost= zeros(G.N,1);
end_ind = zeros(G.N,1);

Nz=numel(Z.cost);
for(z=1:Nz)
    this_track=Z.sub{z};
    sub1=this_track(1);
    ind1=G.S.D(sub1,1);
    sub2=this_track(end);
    ind2=G.S.D(sub2,end);
    if(  start_cost(ind1)>Z.cost(z)  )
        start_cost(ind1)=Z.cost(z);
        start_ind(ind1)=z;
    end
    
    if(  end_cost(ind2)>Z.cost(z)  )
        end_cost(ind2)=Z.cost(z);
        end_ind(ind2)=z;
    end
end

inds_keep=unique([start_ind,end_ind]);
inds_keep=setdiff(inds_keep,[0]);


[~,order_made]=sort(Z.cost(inds_keep));
Nk=min([G.opt.num_keep,numel(inds_keep)]);
inds_keep=inds_keep(order_made(1:Nk));
Z.cost=Z.cost(inds_keep);
Z.sub=Z.sub(inds_keep);

%jy_out_sz('unique(inds_keep)',unique(inds_keep))
%pause

