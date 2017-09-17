function [T,tot_resid]=get_new_cols(G,dual_sol,T)

dyn_info=set_up_dyn(G,dual_sol);
Z=do_dyn_forward(G,dyn_info);

inds_keep=find(Z.cost<0);

[T_new,resid]=convert_dyn_2_mat(G,Z);
T=augment_T(T,T_new);
tot_resid=sum(resid);

