%Execution
function H = main_julian(path)
rand('twister',0);
F=read_data(path);

params=[];
params.por_dock=0.05;
params.offset_subtracks_cost=-100;
G=pre_process_stage1(F,params);
G=pre_process_stage2(G);
G=pre_process_stage3(G);

G=initalize_params(G);


H=Athena(G);
end