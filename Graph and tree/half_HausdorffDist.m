function distance = half_HausdorffDist(detection, neuron_data)%
% Data should be of form 2*N
N = size(neuron_data,2);
distance = [];
for i=1:N
distance(end+1) = min(sum(abs(detection - neuron_data(:, i)*ones(1,size(detection,2))),1));
end