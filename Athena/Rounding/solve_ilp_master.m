function [primal_sol,lp_val]=solve_ilp_master(G,T)


[C,A,B]=form_LP(G,T);
n_tracks=size(T.X,2);
my_opts=optimoptions('intlinprog','Display','off');
[prim_info,lp_val]=intlinprog(C,[1:n_tracks],A,B,[],[],C*0,C*0+1,my_opts);

primal_sol=[];
primal_sol.prim_info=prim_info;
primal_sol.X=T.X(:,prim_info>0.5);

primal_sol.sub=T.sub(:,prim_info>0.5);