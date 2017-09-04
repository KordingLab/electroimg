function [T,tot_resid]=get_new_cols(G,dual_sol,T)

dyn_info=set_up_dyn(G,dual_sol);
Z=do_dyn_forward(dyn_info);
[T_new,resid]=convert_dyn_2_mat(G,dual_sol,Z);
T=augment_T(T,T_new);
tot_resid=sum(resid);

