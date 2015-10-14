clear
clc
N_neurons = 2;
Neuron_positions = 1-2*rand(4,N_neurons);
Electrod_positions = 1-2*rand(3,28);
obs = evalpotential(Electrod_positions,Neuron_positions,.1);
fx = @(x)pointchargefn(x,obs,Electrod_positions);
options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
Sample = 10:2:150;
Sample = 100:110;
Sample = 230;
P = zeros(4*N_neurons+1,size(Sample,2));
% P is the best approximation of location of neurons based on method
% first raw is error and rests are charge + position
count = 1;
Count = 1;
for j =  1:size(Sample,2)
    for i = 1:Sample(j)
        Count = Count +1;
    end
end

for j =  1:size(Sample,2)
    for i = 1:Sample(j)
        Xstart = 1-2*randn(4*N_neurons,1);
        [X,FVAL] = fminunc(fx,Xstart,options);
        a(1,i) = sum((X-reshape(Neuron_positions,4*N_neurons,1)).^2);
        a(2:(4*N_neurons+1),i) = X;
        count/Count
        count = count +1;
    end
    [A,B] = min(a(1,:));
    P(:,j) = a(:,B);
    P(1,j)
reshape(P(2:end,j),4,2)
Neuron_positions
end
