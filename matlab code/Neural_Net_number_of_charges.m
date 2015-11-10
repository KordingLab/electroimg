%% Preparing training Data for number of point charge
clear 
clc
Datatrain = [];
labeltrain = [];
a = 1;
d = 6;
for i = 1:3
    for j = 1:4000
neuron_data = 1-2*rand(4,3*i);
[X,Y,Z] = meshgrid(-1:2/(d-1):1,-1:2/(d-1):1,-1:2/(d-1):1);
X = reshape(X,1,d^3);
Y = reshape(Y,1,d^3);
Z = reshape(Z,1,d^3);
Datatrain(:,a) = evalpotential([X;Y;Z],neuron_data);
labeltrain(a) = i;
a = a+1;
    end
end

Datatest = [];
labeltest = [];
a = 1;
for i = 1:3
    for j = 1:30
neuron_data = 1-2*rand(4,3*i);
[X,Y,Z] = meshgrid(-1:2/(d-1):1,-1:2/(d-1):1,-1:2/(d-1):1);
X = reshape(X,1,d^3);
Y = reshape(Y,1,d^3);
Z = reshape(Z,1,d^3);
Datatest(:,a) = evalpotential([X;Y;Z],neuron_data);
labeltest(a) = i;
a = a+1;
    end
end

%% training Network

net = patternnet([50,30],'trainlm','sse');
net = train(net, Datatrain, labeltrain);
%% Test
result = round(net(Datatest));
plot(1:size(result,2),result,'.')
hold on;
plot(labeltest)
