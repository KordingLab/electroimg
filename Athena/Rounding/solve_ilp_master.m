function [lp_val,lp_val]=solve_ilp_master(G,T)


[C,A,B]=form_LP(T);
n_tracks=size(T.X,2);
[prim_info,lp_val]=intlinprog(C,[1:n_tracks],A,B,[],[],C*0,C*0+1.1);

primal_sol=[];
primal_sol.prim_info=prim_info;


