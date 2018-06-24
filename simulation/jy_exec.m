%% TEST: Simulation
clear
data = open('neuron1.mat');swc_matrix = data.neuron;
%swc_matrix = all_neurons{15000};
s = SimElecRec;
initialization = [0,0,0,1];
% Simulation
[sim,~ ,~ , time_location_amp] = ...
    s.simulation(initialization, swc_matrix, 150, 1);

% extracting the sub-tracks of the detections
k = 2;
threshold = 400;
subtracks = s.subtracks(time_location_amp, k, threshold);

%subtracks(:, 4) = -100;

clear k threshold
% Save 
%parent_index = n(:,7);
%save('parent_index','parent_index')
save('/your_path/time_location_amp.mat','time_location_amp')
save('/your_path/cash simulation/subtracks.mat','subtracks')
save('/your_path/neuron.mat','swc_matrix')
%
H=main_julian('/your_path/subtracks.mat');
s.get_reconstruct(H, size(swc_matrix,1), '/your_path/time_location_amp'...
,'/your_path/reconstructed.mat')