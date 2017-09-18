function [T,tot_resid]=get_new_cols(G,dual_sol,T)
%G
%dual_sol
dyn_info=set_up_dyn(G,dual_sol);
Z=do_dyn_forward(G,dyn_info);
if(numel(Z.cost)>0.5)
    [T_new,resid]=convert_dyn_2_mat(G,Z);
    
    if(sum([dual_sol.lambda_1;dual_sol.lambda_2])<.0001 )
        if(.01<sum(abs(Z.cost-T_new.Theta)))
            jy_out_sz('Z.cost',Z.cost)
            jy_out_sz('resid',resid)
            jy_out_val('[Z.cost,T_new.Theta]',[Z.cost,T_new.Theta])
            disp('no match')
            pause
        end

    end
    T=augment_T(T,T_new);
    tot_resid=resid;

else
    tot_resid=0;
    
end
