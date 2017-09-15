function [dock_in]=con_dock_in(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};
    this_doc=G.dock_in(sub_in(1));
    v1=[v2;this_doc];
    v2=[v1;z];

end

v3=v1*0+1;

dock_in=sparse(v1,v2,v3,G.n_dock,numel(Z.cost));
