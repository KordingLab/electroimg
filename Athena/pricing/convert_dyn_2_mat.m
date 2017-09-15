function [T_new,resid]=convert_dyn_2_mat(G,Z)

if(max(Z.resid_list)>=0)
    disp('flag me no good')
    pause
end
resid=sum(Z.resid_list);
T_new=[];

T_new.sub=con_sub(G,Z);
T_new.X=con_x(G,Z);
T_new.non_start=con_non_start(G,Z);

T_new.Theta=con_Theta(G,Z);
T_new.dock_in=con_dock_in(G,Z);
T_new.dock_out=con_dock_out(G,Z);
