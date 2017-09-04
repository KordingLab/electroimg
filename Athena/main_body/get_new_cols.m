function [T,tot_resid]=get_new_cols(G,dual_sol,T)

[T_new,resid]=do_dyn_forward(G,dual_sol,T);

tot_resid=sum(resid);
T=[];  
T.X=[T.X,T_new.X];
T.Theta=[T.Theta,T_new.Theta];
T.sub=[T.sub,T_new.sub];
T.dock_in=[T.dock_in,T_new.dock_in];
T.dock_out=[T.dock_out,T_new.dock_out];
