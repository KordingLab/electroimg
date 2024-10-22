function [T,tot_resid]=get_new_cols(G,dual_sol,T)
%G
%dual_sol
dyn_info=set_up_dyn(G,dual_sol);
Z=do_dyn_forward(G,dyn_info);
tot_resid=0;
if(numel(Z.cost)>0.5)
    tot_resid=sum(Z.cost);
    Z=determine_keep(G,Z);
    [T_new]=convert_dyn_2_mat(G,Z,dual_sol);

    if(sum([dual_sol.lambda_1;dual_sol.lambda_2])<.0001 )
        if(.01<sum(abs(Z.cost-T_new.Theta)))
            jy_out_sz('Z.cost',Z.cost)
            jy_out_sz('resid',resid)
            jy_out_val('[Z.cost,T_new.Theta]',[Z.cost,T_new.Theta])
            disp('no match')
            pause
        end

    end
    T=augment_T(T,T_new,Z.cost);

else
    tot_resid=0;
    
end
