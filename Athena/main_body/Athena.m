function H=Athena(G)

H=[];
H.lb=[];
H.lp=[];
H.timer=[];

T=[];

T.X=[];
T.non_start=[];
T.Theta=[];
T.sub=[];
T.dock_in=[];
T.dock_out=[];
dual_sol=[];
dual_sol.lambda_1=zeros(G.N,1);
dual_sol.lambda_2=zeros(G.ND,1);

lp_val=0;
primal_sol=[];
for(step=1:G.opt.num_steps)
    if(step>1.5)
        [primal_sol,dual_sol,lp_val]=solve_lp_master(G,T);
    end
    [T,tot_resid]=get_new_cols(G,dual_sol,T);
%

    lb=lp_val+tot_resid;
    H.lp=[H.lp;lp_val];
    H.lb=[H.lb;lb];
%
    jy_out_val('step',step)
    jy_out_val('min(H.lp)',min(H.lp))
    jy_out_val('tot_resid',tot_resid)
    jy_out_val('max(H.lb)',max(H.lb))
    disp('---------')
    if(tot_resid>-G.opt.epsilon)
        break;
    end   
    
end

[primal_int_sol,ub]=solve_ilp_master(G,T);
H.lineage=get_lineage(G,primal_int_sol);
H.ub=ub;
jy_out_val('ub',ub)
H.primal_int_sol=primal_int_sol;

