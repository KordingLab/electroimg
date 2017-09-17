function out_mat=con_sub(G,Z)

v1=[];
v2=[];
v3=[];
%jy_out_val('numel(Z.cost)',numel(Z.cost))
for(z=1:numel(Z.cost))
    tmp=Z.sub{z};
    tmp=tmp(:);
    v1=[v1;tmp];
    v2=[v2;z*ones(numel(tmp),1)];
end
v3=(0*v2)+1;
%jy_out_val('max(v2)',max(v2))
%jy_out_val('G.NS',G.NS)
out_mat=sparse(v1,v2,v3,G.NS,max(v2));