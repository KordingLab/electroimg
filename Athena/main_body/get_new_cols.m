function [T,tot_resid]=get_new_cols(G,dual_sol,T)

T1=do_dyn_forward(G,dual_sol,T);
T1=do_dyn_backward(G,dual_sol,T);

T0=[];
T0.X=[T1.X,T2.X;];
T0.Theta=[T1.Theta,T2.Theta];
T0.red_cost=[T1.red_cost,T2.red_cost];
T0.sub_incl=[T1.sub_inc,T2.sub_inc];
T0.sub_dock=[T1.sub_dock,T2.sub_dock];
T0.sub_in=[T1.sub_in,T2.sub_in];
T0.sub_out=[T1.sub_out,T2.sub_out];

[~,my_order]=sort(T0.red_cost);
T0.X=T0.X(:,my_order);
T0.Theta=T0.Theta(my_order);
T0.sub_incl=T0.sub_incl(:,my_order);
T0.sub_in=T0.sub_in(:,my_order);
T0.sub_out=T0.sub_out(:,my_order);
T0.sub_dock=T0.sub_dock(:,my_order);

[~,set_keep]=unique(T0.X,'rows');
set_keep=set_keep(1:G.opt.max_keep);
T.X=[T.X,T0.X(:,set_keep)];
T.Theta=[T.Theta;T0.Theta(set_keep)];
T.sub_incl=[T.sub_incl,T0.sub_incl(:,set_keep)];
T.sub_in=[T.sub_in,T0.sub_in(:,set_keep)];
T.sub_out=[T.sub_out,T0.sub_out(:,set_keep)];
T.sub_dock=[T.sub_dock,T0.sub_dock(:,set_keep)];
