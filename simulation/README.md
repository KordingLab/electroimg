# Installing
The code is written in one class: SimElecRec.m
Download the script and add the path to the Matlab path. Then drag neuron file (neuron1.mat) to the current folder. To run the code, type:

```
Sim = SimElecRec;
data = open('neuron1.mat');
swc_matrix = data.neuron;
initialization = [0,0,0,1];
T = 150; % overall time to run the simulation
dt = 1; % step time 
k = 2; % Number of detections in a sub-track.

[all_index_amp_active, all_location_detections, index_location_amp_time] = ...
    Sim.simulation(initialization, swc_matrix, T, dt);
```
Then the required matrix can be extracted by:

```
subtracks = s.subtracks(index_location_amp_time, k, 1);

D = index_location_amp_time(:,2:6);
P = swc_matrix(:, 7);
C = index_location_amp_time(:, 1);
S = subtracks(:, 5:end);
```

To find the grandtruth:
```
grand_truth = Sim.grand_truth(D, P, C, S, k)
```
To find reduced cost, first we should compute theta functions:

```
[theta_plus, theta_minus, theta_zero] = Sim.theta_cost(S);
```
Then for a given track, p, the element of reduced cost is computed as following. 

1) cost function

```
s_plus, s_minus, s_zero = Sim.s_function(p, S)
theta = sum(theta_plus(s_plus)) + sum(theta_minus(s_minus)) + sum(theta_zero(s_zero));
```

X and hat_X:

```
X, X_hat = Sim.s_function(p, S);

```
