function T=augment_T(T,T_new)
check_on=1;
if(check_on && numel(T.X)>0)

    [a1,a2]=ismember(T_new.X',T.X','rows');
    if(sum(a1)>0.5)
        jy_out_val('sum(a1)',sum(a1))
        jy_out_sz('a1',a1)
        disp('duplicate present')
        pause;
    end
end
T.X=[T.X,T_new.X];
T.non_start=[T.non_start,T_new.non_start];
T.Theta=[T.Theta;T_new.Theta(:)];
T.sub=[T.sub,T_new.sub];
T.dock_in=[T.dock_in,T_new.dock_in];
T.dock_out=[T.dock_out,T_new.dock_out];