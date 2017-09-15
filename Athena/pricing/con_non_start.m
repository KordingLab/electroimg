function out_mat=con_non_start(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    tmp=[];
    sub_in=Z.sub{z};
    for(i=1:numel(sub_in))
        tmp=[tmp,G.sub2end_det(sub_in(i))];
    end
    v1=[v1;tmp];
    v2=[v2;z*numel(tmp)];
end

v3=(0*v2)+1;
out_mat=sparse(v1,v2,v3,G.N,max(v2));
