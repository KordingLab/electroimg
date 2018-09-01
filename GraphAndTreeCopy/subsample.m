function subsample_neuron = subsample(neuron, n_nodes_to_delete)
subsample_neuron = neuron;
for i =1:n_nodes_to_delete
    subsample_neuron = remove_one_node(subsample_neuron);
end


