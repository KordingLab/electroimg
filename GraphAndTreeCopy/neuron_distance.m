function distance = neuron_distance(neuron1, neuron2)
P = neuron1(:,3:4);
Q = neuron2(:,3:4);
distance = HausdorffDist(P,Q);