function R=set_up_dyn(G,dual_sol)

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

