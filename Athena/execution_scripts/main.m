%Execution
addpath('../data')
addpath('../main_body')
addpath('../preprocess')
in_name='my_data_file.mat';
G=preprocess(in_name);

G.opt.my_params=[];

H=Athena(G);