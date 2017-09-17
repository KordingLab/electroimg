function out_mat=con_x(G,Z)

v1=[];
v2=[];

for(z=1:numel(Z.cost))
    sub_in=Z.sub{z};
    tmp=G.S.D(sub_in(1),:);
    for(i=2:numel(sub_in))
        tmp=[tmp,G.S.last_det(sub_in(i))];
    end
    %disp('-----')
    %z
    %v1
    %v2
    %disp('@@@@@@@@@@@@')
    v1=[v1;tmp(:)];
    v2=[v2;z*ones(numel(tmp),1)];
end

v3=(0*v2)+1;
%jy_out_sz('v1',v1)
%jy_out_sz('v2',v2)
%jy_out_sz('v3',v3)
out_mat=sparse(v1,v2,v3,G.N,max(v2));
