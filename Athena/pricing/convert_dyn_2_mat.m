function [T_new,resid]=convert_dyn_2_mat(G,Z)

if(max(Z.cost)>=0)
    jy_out_val('max(Z.cost)',max(Z.cost))
    disp('flag me no good')
    pause
end
resid=sum(Z.cost);
T_new=[];

T_new.sub=con_sub(G,Z);
T_new.X=con_x(G,Z);
T_new.non_start=con_non_start(G,Z);

T_new.Theta=con_Theta(G,Z);
T_new.dock_in=con_dock_in(G,Z);
T_new.dock_out=con_dock_out(G,Z);
