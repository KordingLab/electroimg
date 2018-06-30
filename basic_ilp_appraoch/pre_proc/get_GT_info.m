
function G=get_GT_info(G)


bar_E=G.F.bar_E(G.B.old_2_new_order,G.B.old_2_new_order);

sol_vec=bar_E(G.B.E_ind_on);


GT=sol2desc(G,sol_vec);

GT.sol_vec=sol_vec;
GT.bar_E=bar_E;
G.GT=GT;


