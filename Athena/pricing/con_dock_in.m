function [dock_in]=con_dock_in(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};
    this_doc=G.S.dock_start_ind(sub_in(1));
    if(this_doc<0.5)
        disp('nosence')
        jy_out_val('sub_in',sub_in)
        jy_out_val('this_doc',this_doc)
        jy_out_val('sub_in(1)',sub_in(1))
        disp('nosence')

        pause
    end
    v1=[v1;this_doc];
    v2=[v2;z];
    
end

v3=v1*0+1;

%jy_out_sz('v1',v1)
%jy_out_sz('v2',v2)
%jy_out_sz('v3',v3)
dock_in=sparse(v1,v2,v3,G.ND,numel(Z.cost));
