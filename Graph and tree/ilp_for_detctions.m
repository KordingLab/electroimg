function H = ilp_for_detctions(x, y, time, W, split_cost, edge_offset, max_kids, max_splits)
F=[];
F.x=x;
F.y=y;
F.z=ones(length(x),1);
F.time=time;
F.bar_E=zeros(size(W));
F.W=W;
%
my_params=[];
my_params.split_cost=split_cost;%  Between 0 and 10q
my_params.max_splits=max_splits; % can be -1 for for split
my_params.edge_offset=edge_offset;%-.1;% Between q and -q
my_params.max_kids=max_kids;

my_params.my_rand_seed=0;
my_params.por_split=.5;
my_params.epsilon=.0000001;
% F=load_data(my_input_file)
G=pre_process(F,my_params);
H=call_basic_ilp_solve(G);