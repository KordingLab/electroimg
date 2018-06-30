function G=pre_process(F,my_params)

G=[];
G.F=F;
G.params=my_params;%get_params(G);
G=get_graph_struct(G);

G=get_GT_info(G);

G=get_split_poss(G);

G=get_ILP(G);


