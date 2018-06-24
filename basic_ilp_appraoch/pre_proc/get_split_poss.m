function G=get_split_poss(G)

rand('twister',G.params.my_rand_seed);
num_split=ceil(G.B.N*G.B.por_split);
num_split=min([G.B.N,num_split]);
has_kid_list=find(G.B.num_kids>0.5);

split_list=has_kid_list(  randperm(numel(has_kid_list)));
split_list=split_list(1:num_split);
G.split_list=split_list;