%% Preparing training Data for number of point charge
Datatrain = [];
labeltrain = [];
a = 1;
for i = 1:2
    for j = 1:3000
neuron_data = 1-2*rand(4,i);
[X,Y,Z] = meshgrid(-1:.5:1,-1:.5:1,-1:.5:1);
X = reshape(X,1,125);
Y = reshape(Y,1,125);
Z = reshape(Z,1,125);
Datatrain(:,a) = evalpotential([X;Y;Z],neuron_data);
labeltrain(a) = i;
a = a+1;
    end
end

Datatest = [];
labeltest = [];
a = 1;
for i = 1:2
    for j = 1:30
neuron_data = 1-2*rand(4,i);
[X,Y,Z] = meshgrid(-1:.5:1,-1:.5:1,-1:.5:1);
X = reshape(X,1,125);
Y = reshape(Y,1,125);
Z = reshape(Z,1,125);
Datatest(:,a) = evalpotential([X;Y;Z],neuron_data);
labeltest(a) = i;
a = a+1;
    end
end

%% training Network

net = patternnet([14,5],'trainlm','sse');
net = train(net, Datatrain, labeltrain);
%% Test
result = round(net(Datatest));
plot(result)
hold on;
plot(labeltest)
sum(result(1:30))
sum(result(31:60))
