%Execution
addpath('../data')
addpath('../main_body')
addpath('../pre_process')
addpath('../LP')
addpath('../jy_fun')
addpath('../Rounding')
addpath('../pricing')
in_name='../data/subtracks.mat';
F=read_data(in_name);

params=[];
params.por_dock=0.05;
params.offset_subtracks_cost=-3;
G=pre_process_stage1(F,params);
G=pre_process_stage2(G);
G=pre_process_stage3(G);

G=initalize_params(G);


H=Athena(G);