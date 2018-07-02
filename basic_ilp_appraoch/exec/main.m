%% Simulating Data
clc
clear
path = '/Users/RoozbehFarhoudi/Documents/Repos/electroimg/Graph and tree/neuron_file/neuron1.mat';
[x, y, z, time, W, E] = tree_neuron(path, 500);
x = x - x(1);
y = y - y(1);
z = z - z(1);

%% Running the slover
close all

my_params=[];
my_params.split_cost=0;
my_params.max_splits=-1;
my_params.edge_offset=-0.4;
my_params.my_rand_seed=0;
my_params.por_split=1;
my_params.epsilon=.000001;

addpath ../body
addpath ../pre_proc
addpath ../../Athena/jy_fun

my_input_file='../data/roosbeh_sort.mat';
my_output_file='../output/basic_out.mat';




F=load_data(my_input_file);
G=pre_process(F,my_params);
H=call_basic_ilp_solve(G);
save(my_output_file,'H');

%% The extrcted neuron
par = H.Ebar.par;
par(1) = 1;

%% ground truth
par = parent_index(E);

%% Making swc output
swc = get_swc(par, x, y, z);

%% Plot the tree
plot_neuron(swc)
