%Execution
addpath('../data')
addpath('../main_body')
addpath('../pre_process')
addpath('../LP')
addpath('../Rounding')
addpath('../pricing')
in_name='../data/subtracks.mat';
F=read_data(in_name);

params=[];
params.por_dock=0.5;
G=pre_process_stage1(F,params);
G.opt.my_params=[];


H=Athena(G);