Simulating propagation of electrical activities through morphology of a neuron. 

## Installation
Download the script and add the path to the Matlab path. Then drag neuron file (neuron1.mat) to the current folder. To run the code, type:

## Usage
The code is orgonized by one class: SimElecRec.m
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
Then the subtracks for a fixed length k can be extracted by:

```
subtracks = Sim.subtracks(index_location_amp_time, k, 1);

D = index_location_amp_time(:,2:6);
P = swc_matrix(:, 7);
C = index_location_amp_time(:, 1);
S = subtracks(:, 5:end);
```

To get Q_{s_1, s_2} (sparse matrix with the size of number of subtracks):
```
Q = Sim.q_matrix(S);
```
To get theta cost function:
```
[theta_plus, theta_minus, theta_zero] = Sim.theta_cost(S);
```
A track is represented by a binary vector with the size of number of subtracks.  

To find the ground truth track:
```
ground_truth = Sim.ground_truth(D, P, C, S, k)
```
For a given track, p, all the elements required to compute reduced cost (in the constrain of optimization) can be extracted as following:

1) $X$ and $\hat{X}$:
```
X, X_hat = Sim.x_function(p, S);
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

All of this variables can be infered once reduced_cost_elem is called:
```
[Theta, X_hat, X, s_plus, s_minus, s_zero, sigma_q] = ...
    Sim.reduced_cost_elem(p, k, D, P, C, S, Q, theta_plus, theta_minus, theta_zero);
```
## Using for tracking the segments
to find the solution of reduced cost:
```
p = Sim.find_solution(starting_point, S, X)
```
to plot the solution:
```
Sim.plot_solution(D, S, p)
```
