%Execution
addpath('../data')
addpath('../main_body')
addpath('../preprocess')
addpath('../LP')
addpath('../Rounding')
addpath('../pricing')
in_name='my_data_file.mat';
F=read_data(in_name);
G=preprocess(F);

G.opt.my_params=[];

H=Athena(G);