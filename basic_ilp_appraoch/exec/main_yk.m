
%% Running the slover
close all

my_params=[];
my_params.split_cost=0;
my_params.max_splits=-1;
my_params.edge_offset=-0.4;
my_params.my_rand_seed=0;
my_params.por_split=1;
my_params.max_kids=3;
my_params.epsilon=.000001;

addpath ../body
addpath ../pre_proc
addpath ../../Athena/jy_fun

my_input_file='../../yuck.mat';
my_output_file='../output/basic_out.mat';



disp('load data')
F=load_data_new(my_input_file);

disp('pre-process data')

G=pre_process(F,my_params);
disp('calling ILP on data')

H=call_basic_ilp_solve(G);
disp('done ILP')
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
