function subsample_neuron = remove_one_node(neuron)

subsample_neuron = neuron;
children_node = [];
while length(children_node)~=1
node_to_delete = floor((size(subsample_neuron, 1)-1)*rand)+2;
children_node = find(subsample_neuron(:,7) == node_to_delete);
end
par_node = subsample_neuron(node_to_delete,7);
subsample_neuron(children_node, 7) = par_node;
I = find(subsample_neuron(:,7)>node_to_delete);
subsample_neuron(I, 7) = subsample_neuron(I, 7) -1;
subsample_neuron = subsample_neuron([1:node_to_delete-1, node_to_delete+1:end], :);
