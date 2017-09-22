function out_mat=con_non_start(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    tmp=[];
    sub_in=Z.sub{z};
    
    for(i=1:numel(sub_in))
        tmp=[tmp,G.S.last_det(sub_in(i))];
    end
    if(G.S.starts_soma(sub_in(1))==1)
        extra_term=G.S.D(sub_in(1),1:end-1);
        tmp=[tmp,extra_term(:)];
    end
    
    v1=[v1;tmp(:)];
    v2=[v2;z*ones(numel(tmp),1)];
end

v3=(0*v2)+1;
out_mat=sparse(v1,v2,v3,G.N,max(v2));
