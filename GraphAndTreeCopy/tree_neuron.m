function [x, y, z, time, W, E] = tree_neuron(path, number_of_noise)

%%%%%%%%%% Reading the data %%%%%%%%%%
data = open(path);
swc_matrix = data.neuron;
neuron_locations = transpose(swc_matrix(:, 3:5));
parent_index = swc_matrix(:, 7);
n_nodes = size(swc_matrix, 1);
% Normalize the values of the location between 0 and 1
for i = 1:3
    cor = neuron_locations(i,:);
    cor = (cor - min(cor))/(max(cor)-min(cor));
    neuron_locations(i,:) = cor;
end

%%%%%%%%%% Initialization %%%%%%%%%%
% detections are the nodes on the neurons plus other noise
number_of_detections = number_of_noise+n_nodes;
graph  = randperm(number_of_detections);
% index of neuron's node in the graph
neuron_index = graph(1:n_nodes);
% initialize the location for all detections with random values
locations = rand(3, number_of_detections);
time = ones(1, number_of_detections);
locations(:, neuron_index) = neuron_locations;

%%%%%%%%%% Active nodes %%%%%%%%%%
t = 1;
active_neuron_index = 1;
% While loop to findthe active nodes on the neuron at each time
while (length(active_neuron_index) ~= 0)
    activties = [];
    for i=active_neuron_index
        activties = [activties, transpose(find(parent_index == i))];
    end
    time(neuron_index(activties)) = t+1;
    t = t + 1;
    active_neuron_index = activties;
end
max_time = max(time);
% Filling the rest of time with random values
time(graph(n_nodes+1:end)) = floor((max_time-1)*rand(1,number_of_detections-n_nodes))+2;

%%%%%%%%%% Outputing %%%%%%%%%%soret
% W matrix as sparse matrix of the cost function
W = sparse(number_of_detections, number_of_detections);
for i = 2:max_time
    t_i = find(time == i);
    t_i_1 = find(time == i-1);
    for j = t_i
        for k = t_i_1
            W(j,k) = sqrt(sum((locations(:,j)-locations(:,k)).^2));
        end
    end
end

% E matrix as sparse matrix that shows the neuron
E = sparse(number_of_detections, number_of_detections);
for i =2:n_nodes
    E(neuron_index(i), neuron_index(parent_index(i))) = 1;
end

% xys of locations
x = locations(1, :);
y = locations(2, :);
z = locations(3, :);

% sorts the indices by time
[~, argsort] = sort(time);
time = time(argsort);
x = x(argsort);
y = y(argsort);
z = z(argsort);
W = W(argsort,argsort);
E = E(argsort,argsort);
