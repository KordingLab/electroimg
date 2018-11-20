function [x, y, time, W, E, Epar] = tree_neuron(swc_matrix, cost, ...
    threshold_dis_connect, edge_coff, consecuatve_frames, number_of_noise, number_of_missing_nodes,...
    stick_binary_tree)

%%%%%%%%%% Reading the data %%%%%%%%%%
neuron_locations = transpose(swc_matrix(:, 3:4));
parent_index = swc_matrix(:, 7);
n_nodes = size(swc_matrix, 1);
% Normalize the values of the location between 0 and 1
% for i = 1:3
%     cor = neuron_locations(i,:);
%     cor = (cor - min(cor))/(max(cor)-min(cor));
%     neuron_locations(i,:) = cor;
% end

%%%%%%%%%% Initialization %%%%%%%%%%
% detections are the nodes on the neurons plus other noise
number_of_detections = number_of_noise+n_nodes;
% initialize the location for all detections with random values
locations = rand(2, number_of_detections);

time = ones(1, number_of_detections);
locations(:, 1:n_nodes) = neuron_locations;
%%%%%%%%%% Active nodes %%%%%%%%%%
t = 1;
active_neuron_index = 1;
% While loop to findthe active nodes on the neuron at each time
while (length(active_neuron_index) ~= 0)
    activties = [];
    for i=active_neuron_index
        activties = [activties, transpose(find(parent_index == i))];
    end
    time(activties) = t+1;
    t = t + 1;
    active_neuron_index = activties;
end
max_time = max(time);
% Filling the rest of time with random values
time(n_nodes+1:end) = floor((max_time-1)*rand(1,number_of_detections-n_nodes))+2;

%%%%%%%%%% Remove nodes (missing nodes) %%%%%%%%%%
% Some nodes from neurons should be removed. They represent the fact
% that in recording, it is possible for dismiss some part of ground truth.

[subsample_neuron, mapping] = subsample(swc_matrix, number_of_missing_nodes, stick_binary_tree);
n_nodes = n_nodes - number_of_missing_nodes;
number_of_detections = number_of_detections - number_of_missing_nodes;

all_index = [mapping, n_nodes+1:number_of_detections];

parent_index = subsample_neuron(:, 7);

time = time(all_index);
locations = locations(:, all_index);
%%%%%%%%%% Outputing %%%%%%%%%%%%%%
% W matrix as sparse matrix of the cost function
W = sparse(number_of_detections, number_of_detections);
for s=1:consecuatve_frames
for i = 2:max_time
    t_i = find(time == i);
    t_i_1 = find(time == i-s);
    for j = t_i
        for k = t_i_1
            distance_edge = sqrt(sum((locations(:,j)-locations(:,k)).^2));
            if strcmp(cost, 'distance')
                if distance_edge<threshold_dis_connect*s
                    W(j,k) = edge_coff * (threshold_dis_connect - distance_edge)/s;
                else
                    
                    W(j,k) = 0;
                end
            else
                if strcmp(cost, 'constant')
                    if distance_edge<threshold_dis_connect
                        W(j,k) = .1;
                    else
                        W(j,k) = 0;
                    end
                end
            end
        end
    end
end
end

% E matrix as sparse matrix that shows the neuron
E = sparse(number_of_detections, number_of_detections);
for i =2:n_nodes
    E(i, parent_index(i)) = 1;
end

% xys of locations
x = locations(1, :);
y = locations(2, :);
%z = locations(3, :);

% sorts the indices by time
[~, argsort] = sort(time);
time = time(argsort);
x = x(argsort);
y = y(argsort);
%z = z(argsort);
W = W(argsort,argsort);
E = E(argsort,argsort);
Epar = zeros(size(E,1),1);
for i =1:size(E,1)
    j = find(E(i,:)==1);
    if(size(j,2)~=0)
        Epar(i) = j;
    end
end
