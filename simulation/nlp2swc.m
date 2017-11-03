%% Select neuron
clc
clear
load('/Volumes/Arch/Dropbox/Projects/HG-GAN/03-Data/All Data/swc1.mat');
all_neurons = A;
clear A

%% TEST: Simulation
clear
data = open('neuron1.mat');swc_matrix = data.neuron;
%swc_matrix = all_neurons{15000};
s = SimElecRec;
initialization = [0,0,0,1];
% Simulation
[sim, ~, ~, time_location_amp] = ...
    s.simulation(initialization, swc_matrix, 150, 1);

% extracting the sub-tracks of the detections
k = 2;
threshold = 400;
subtracks = s.subtracks(time_location_amp, k, threshold);
clear k threshold
% Save 
%parent_index = n(:,7);
%save('parent_index','parent_index')
save('/Volumes/Arch/Dropbox/Projects/Electrical Imaging/cash simulation/time_location_amp.mat','time_location_amp')
save('/Volumes/Arch/Dropbox/Projects/Electrical Imaging/cash simulation/subtracks.mat','subtracks')
save('/Volumes/Arch/Dropbox/Projects/Electrical Imaging/cash simulation/neuron.mat','swc_matrix')
%
H=main_julian('/Volumes/Arch/Dropbox/Projects/Electrical Imaging/cash simulation/subtracks.mat');
s.get_reconstruct(H, size(swc_matrix,1), '/Volumes/Arch/Dropbox/Projects/Electrical Imaging/cash simulation/time_location_amp'...
,'/Volumes/Arch/Dropbox/Projects/Electrical Imaging/cash simulation/reconstructed.mat')

