function [primal_sol,dual_sol,lp_val]=solve_lp_master(G,T)

warning off;
[C,A,B]=form_LP(G,T);
options = optimoptions('linprog','Display','off');

prim_info=[];
lp_val=[];
dual_info=[];
if(G.opt.do_primal>0.5)
    [prim_info,lp_val,~,~,dual_info]=linprog(C,A,B,[],[],C*0,C*0+1.1,[],options);
    dual_info=dual_info.ineqlin;
else
    Bp=B;
    Bp(Bp>.000001)=.000001;
    [dual_info,lp_val,~,~,prim_info]=linprog(Bp,-A',C,[],[],Bp*0,Bp*0+inf,[],options);
    lp_val=-lp_val;
    prim_info=prim_info.ineqlin;

%    lp_val
%    pause
end
primal_sol=[];
primal_sol.prim_info=prim_info;

dual_sol=[];
dual_sol.lambda_1=dual_info(1:G.N);
dual_sol.lambda_2=dual_info(1+G.N:end);
