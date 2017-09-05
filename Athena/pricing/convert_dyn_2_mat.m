function [T_new,resid]=convert_dyn_2_mat(G,Z)

T_new=[];
T_new.Theta=[];
T_new.sub=[];
T_new.X;

fin_det_val=zeros(G.N,1);
fin_det_val=zeros(G.N,1);
for(z=1:numel(Z.red_cost))
    dets_in=G.last_det(Z.Y{z});
    sub_in=Z.Y{z};
    fin_term=G.terminal()
    
end

for(d=1:G.N)
    
end