function out_mat=con_sub(G,Z)

v1=[];
v2=[];
v3=[];
for(z=1:numel(Z.cost))
    v1=[v1;Z.sub_list{z}];
    v2=[v2;z*numel(Z.sub_list{z})];
end
v3=(0*v2)+1;
out_mat=sparse(v1,v2,v3,G.n_sub,max(v2));