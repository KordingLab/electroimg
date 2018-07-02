This file provides output for finding a tree from an acyclic graph.

## tree_neuron
This function make a simulated data from the sample neuron.

#### usage
1) Add tree_neuron.m to the Matlab path.
2) In the command window write:
```
[x, y, z, time, W, E] = tree_neuron(path, number_of_noise);
```

#### Parameters:
`path` is the path to a specific neuron in the neuron file. For example :`path = ./neuron_file/neuron1.mat`. There are 5 neurons in the folder right now.

`number_of_noise` is the number of noisy detections that can be added to the recording.

#### Returns:

`x, y, z`: The locations of all the detections

`time`: timing that a detection is recorded.

`W`: Sparse matrix of the size of all detection with non zero real value weight for a few of them.

`E`:  Sparse matrix of adjacency for the neuron. `E(i,j) = 1` shows that `j` is the parent of `i`. \

## get_swc
This function get the swc from a proposed solution.

#### usage
```
swc = get_swc(parent, x, y, z);
```
#### Parameters:
`parent`: indication of nodes on the neuron. If an array is non zero, its on the neuron. the value is the parent index.
`x, y, z`: The locations of all the detections

## Returns:
`swc`: the n times 7 swc matrix.

## plot_neuron
This function plots neuron from sws format.

#### usage
```
plot_neuron(swc);
```
