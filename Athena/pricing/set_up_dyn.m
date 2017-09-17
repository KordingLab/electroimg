function R=set_up_dyn(G,dual_sol)

start_cost=G.start_cost+G.theta_sub;
start_cost=start_cost+G.M_sub2det*dual_sol.lambda1;
start_cost=start_cost+G.M_sub_start_doc*dual_sol.lambda2;

end_cost=G.term_cost+G.M_sub2_end_doc*dual_sol.lambda2;

R.start_cost=start_cost;

R.sub_cost=G.theta_sub+dual_sol.lambda1(G.det2end);

R.end_cost=end_cost;
