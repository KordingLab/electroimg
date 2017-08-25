function H=Athena(G)

H=[];
H.lb=[];
H.lp=[];
H.timer=[];

T=[];
T.X=[];
T.Theta=[];
T.sub_incl=[];
T.sub_in=[];
T.sub_out=[];

for(step=1:G.opt.num_steps)
    [dual_sol,~,lp_val]=solve_lp_master(T);
    [T,tot_resid]=get_new_cols(G,dual_sol,T);
%
    H.lp=[H.lp;lp_val];
    H.lb=[H.lb;lp_val+tot_resid];
%
    if(tot_resid<-G.epsilon)
        break;
    end   
    
end

[primal_int_sol,ub]=solve_ilp_master(T);
H.ub=ub;
H.primal_int_sol=primal_int_sol;

