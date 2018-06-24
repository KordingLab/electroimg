function G=get_split_poss(G)

rand('twister',G.params.my_rand_seed);
num_split=ceil(G.B.N*G.params.por_split);
num_split=min([G.B.N,num_split]);
has_kid_list=find(G.B.num_kids>0.5);

split_list=has_kid_list(  randperm(numel(has_kid_list)));
num_split=min([num_split,numel(split_list)]);
split_list=split_list(1:num_split);

sp=[];
sp.split_list=split_list
sp.ns=numel(split_list);
G.sp=sp;