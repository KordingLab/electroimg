function [dock_out]=con_dock_out(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};
    this_doc=G.dock_in(sub_in(end));
    if(this_doc>0.5)
        v1=[v2;this_doc];
        v2=[v1;z];
    end
end

v3=v1*0+1;

dock_out=sparse(v1,v2,v3,G.n_dock,numel(Z.cost));
