function [primal_sol,dual_sol,lp_val]=solve_lp_master(G,T)


[C,A,B]=form_LP(T);

[prim_info,lp_val,~,~,dual_sol]=linprog(C,A,B,[],[],C*0,C*0+1.1);

primal_sol=[];
primal_sol.prim_info=prim_info;
primal_sol.cols_used=prim_info([1:size(T.X,2)]);
primal_sol.docks=prim_info([1+size(T.X,2):end]);


dual_sol=dual_sol.ineqlin;