function T=augment_T(T,T_new)

T.X=[T.X,T_new.X];
T.non_start=[T.non_start,T_new.non_start];
T.Theta=[T.Theta;T_new.Theta(:)];
T.sub=[T.sub,T_new.sub];
T.dock_in=[T.dock_in,T_new.dock_in];
T.dock_out=[T.dock_out,T_new.dock_out];