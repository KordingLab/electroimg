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
    %max()
    Bp(Bp<.000001)=.000001;
    %Bp
    %pause
    [dual_info,lp_val,flag,~,prim_info]=linprog(Bp,-A',C,[],[],Bp*0,Bp*0+inf,[],options);
    lp_val=-lp_val;
    prim_info=prim_info.ineqlin;
    if(flag<0.5)
        disp('yucky in LP')
        flag
        pause
    end
    %jy_out_val('sum(abs(prim_info))',sum(abs(prim_info)))
%    lp_val
%    pause
end
if(lp_val>-.0001)
    disp('im confused')
    lp_val
    pause
else
    %disp('LP value is  find')
    %lp_val
    
end
primal_sol=[];
primal_sol.prim_info=prim_info;

dual_sol=[];
dual_sol.lambda_1=dual_info(1:G.N);
dual_sol.lambda_2=dual_info(1+G.N:end);



det_term=T.non_start'*dual_sol.lambda_1;
start_term=0.5*T.dock_in'*dual_sol.lambda_2;
end_term=-1*T.dock_out'*dual_sol.lambda_2;
reduced_cost_guess=T.Theta+det_term+start_term+end_term;

if(-.0001> min(reduced_cost_guess) )
    [min_val,min_ind]=min(reduced_cost_guess);
    jy_out_val('det_term(min_ind)',det_term(min_ind))
    jy_out_val('start_term(min_ind)',start_term(min_ind))
    jy_out_val('end_term(min_ind)',end_term(min_ind))
    jy_out_val('T.Theta(min_ind)',T.Theta(min_ind))
    disp('problem here in LP solver')
    jy_out_val('min(reduced_cost_guess)',min(reduced_cost_guess))
    pause
end