function Distance = DisNeuRecNeu(Neruon,RecNeuron,low_threshold,high_threshold)
% Neuron and RecNeuron are both 3*N entries. low_threshold and
% high_threshold correspond to lowest and highest values for looking at the
% thresholds. Distance finds thier distance for the range between this two
% values. default bin = .1 
Distance = [];
count = 1;
I =  a:.1:b;
for i = I
[dvec,TP,FP,M,Matches] = centroiderror_missrates([Neuron(1,:),Neuron(2,:),Neuron(3,:)],[RecNeuron(1,:);RecNeuron(2,:);RecNeuron(3,:)],i);
Distance(count) = FP;
count = count + 1;
end