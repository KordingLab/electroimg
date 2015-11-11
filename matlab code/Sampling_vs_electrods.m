%clear
clc
N_neurons = 2;
Neuron_positions = 1-2*rand(4,N_neurons);
Sample = 150:10:250;
%P = zeros(4*N_neurons+1,size(Sample,2),6);
%parfor k = 1:6
k = 5;
    Electrod_positions = 1-2*rand(3,20+5*k);
    obs = evalpotential(Electrod_positions,Neuron_positions);
    fx = @(x)pointchargefn(x,obs,Electrod_positions);
    options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
    a = zeros(4*N_neurons+1,size(Sample,2));
    s = 0;
    for j =  1:size(Sample,2)      
        for i = 1:Sample(j)
            Xstart = 1-2*randn(4*N_neurons,1);
            [X,FVAL] = fminunc(fx,Xstart,options);
            a(1,i) = sum((X-reshape(Neuron_positions,4*N_neurons,1)).^2);
            a(2:(4*N_neurons+1),i) = X;
           (i+j*150)/1500
        end
        [A,B] = min(a(1,:));
    P(:,j,k) = a(:,B);
    end
%end