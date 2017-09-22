function R=set_up_dyn(G,dual_sol)

tot_dual=sum(abs(dual_sol.lambda_1))+sum(abs(dual_sol.lambda_2));
start_cost=G.C.start_cost+G.C.cost;
%start_cost=start_cost+G.M.sub2detmE*dual_sol.lambda_1;%(end);
start_cost=start_cost+G.M.sub2det*dual_sol.lambda_1;%(end);

%

%
start_cost=start_cost+0.5*G.M.sub_start_doc*dual_sol.lambda_2;

end_cost=G.C.term_cost-G.M.sub_end_doc*dual_sol.lambda_2;

R.start_cost=start_cost;

R.sub_cost=G.C.cost+dual_sol.lambda_1(G.S.last_det);

R.end_cost=end_cost;
R.is_first_solve=0;
if(tot_dual<.00000001)
    R.is_first_solve=1;
end

%jy_out_val('R.start_cost(7)',R.start_cost(7))

%pause