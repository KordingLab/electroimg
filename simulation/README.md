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

To get $Q_{s_1s_2}$ (sparse matrix):
```
Q = Sim.q_matrix(S);
```
To get theta cost function:
```
[theta_plus, theta_minus, theta_zero] = Sim.theta_cost(S);
```
A track is represented by a binary vector, p, with the size of number of subtrcks.  

To find the grand truth track:
```
grand_truth = Sim.grand_truth(D, P, C, S, k)
```
For a given track, the element of reduced cost is computed as following:

1) $X$ and $\hat{X}$:
```
X, X_hat = Sim.s_function(p, S);
```
2) $S^{0,+,-}$:
```
s_plus, s_minus, s_zero = Sim.s_function(p, S)
```
3) $\Theta$:
```
theta = sum(theta_plus(s_plus)) + sum(theta_minus(s_minus)) + sum(theta_zero(s_zero));
```
4) $\sum_{s_2}Q_{s_1s_2}S^+_{s_2p}$:
```
sigma_q = Sim.q_function(Q, S, s_plus);
```

All of this variables can be infered by one call also:
```
[Theta, X_hat, X, s_plus, s_minus, s_zero, sigma_q] = ...
    Sim.reduced_cost_elem(p, k, D, P, C, S, Q, theta_plus, theta_minus, theta_zero);
```
