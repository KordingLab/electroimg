function [subsample_neuron, mapping] = subsample(neuron, n_nodes_to_delete, stick_binary_tree)
subsample_neuron = neuron;
mapping = 1:size(neuron, 1);
for i =1:n_nodes_to_delete
    [subsample_neuron, removed_node] = remove_one_node(subsample_neuron, stick_binary_tree);
    mapping(removed_node) = [];
end


