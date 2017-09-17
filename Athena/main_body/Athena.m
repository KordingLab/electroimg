function H=Athena(G)

H=[];
H.lb=[];
H.lp=[];
H.timer=[];

T=[];

T.X=[];
T.non_start_det=[];
T.Theta=[];
T.sub=[];
T.dock_in=[];
T.dock_out=[];
dual_sol=[];
dual_sol.lambda_1=zeros(G.N,1);
dual_sol.lambda_2=zeros(G.ND,1);

lp_val=-inf;
for(step=1:G.opt.num_steps)
    if(step>1.5)
        [dual_sol,~,lp_val]=solve_lp_master(G,T);
    end
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

