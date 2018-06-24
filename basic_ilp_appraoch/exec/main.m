%
clear
close all

my_params=[];
my_params.split_cost=0;
my_params.max_splits=-1;
my_params.edge_offset=0;
my_params.my_rand_seed=0;
my_params.por_split=1;
my_params.epsilon=.000001;

addpath ../body
addpath ../pre_proc
addpath ../jyFun

my_input_file='../data/roosbeh_basic_data.mat';
my_output_file='../output/basic_out.mat';




F=load_data(my_input_file);
G=pre_process(F,my_params);
H=call_basic_ilp_solve(F);
save(my_output_file,'H');