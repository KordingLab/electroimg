function [dock_out]=con_dock_out(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};
    this_doc=G.S.dock_end_ind(sub_in(end));
    if(this_doc>0.5)
        v1=[v1;this_doc];
        v2=[v2;z];
    end
end

v3=v1*0+1;
%disp('-----')
%jy_out_sz('v1',v1)
%jy_out_sz('v2',v2)
%jy_out_sz('v3',v3)
%jy_out_val('max(v2)',max(v2))
%jy_out_val('max(v3)',max(v3))
%jy_out_val('G.ND',G.ND)
%jy_out_val('numel(Z.cost)',numel(Z.cost))
dock_out=sparse(v1,v2,v3,G.ND,numel(Z.cost));
