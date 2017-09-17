function [T,tot_resid]=get_new_cols(G,dual_sol,T)

dyn_info=set_up_dyn(G,dual_sol);
Z=do_dyn_forward(G,dyn_info);
if(numel(Z.cost)>0.5)
    [T_new,resid]=convert_dyn_2_mat(G,Z);
    T=augment_T(T,T_new);
    tot_resid=sum(resid);

else
    tot_resid=0;
    
end

jy_out_sz('')
disp('done one round of generating cols.  Lets examine')
disp('this is not an error')
pause