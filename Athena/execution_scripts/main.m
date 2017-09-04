%Execution
addpath('../data')
addpath('../main_body')
addpath('../preprocess')
addpath('../LP')
addpath('../Rounding')
addpath('../pricing')
in_name='my_data_file.mat';
G=preprocess(in_name);

G.opt.my_params=[];

H=Athena(G);