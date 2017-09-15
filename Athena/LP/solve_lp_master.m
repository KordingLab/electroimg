function [primal_sol,dual_sol,lp_val]=solve_lp_master(T)


[C,A,B]=form_LP(T);

[prim_info,lp_val,~,~,dual_info]=linprog(C,A,B,[],[],C*0,C*0+1.1);

primal_sol=[];
primal_sol.prim_info=prim_info;

dual_info=dual_info.ineqlin;
dual_sol=[];
dual_sol.lambda_1=dual_info(1:G.N);
dual_sol.lambda_2=dual_info(1+G.N:end);
