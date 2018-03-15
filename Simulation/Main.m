%% TEST: Simulation
clc
clear
data = open('neuron1.mat');
n = data.neuron;
neuron_locations = n(:, 3:5);
s = SimElecRec;
initialization = [0,0,0,1];
swc_matrix = n;
T = 150;
dt = 1;
% Simulation
[sim, all_index_amp_active, all_location_detections, time_location_amp] = ...
    s.simulation(initialization, swc_matrix, T, dt);
subtracks = s.subtracks(time_location_amp, 2, 1);