clc
clear
Neuron_positions = 1-2*rand(4,2);
Electrod_positions = 1-2*rand(3,25);
obs = evalpotential(Electrod_positions,Neuron_positions);
Xstart = 1-2*rand(8,1);

options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
X1Hist=zeros(4,1);
X2Hist=zeros(4,1);
for j = 1:1
    Xstart = 1-2*rand(8,1);
for i = 1:10
fx1 = @(x)pointchargefn1(x,Xstart(5:8),obs,Electrod_positions);
[X1,FVAL] = fminunc(fx1,Xstart(1:4),options);

fx2 = @(x)pointchargefn2(x,X1,obs,Electrod_positions);
[X2,FVAL] = fminunc(fx2,Xstart(5:8),options);
Xstart = [X1;X2];
X1Hist(:,i) = X1;
X2Hist(:,i) = X2;
end

%Neuron_positions
Xstart
pointchargefn(Xstart,obs,Electrod_positions)
end
%%
pointchargefn(reshape(Neuron_positions,8,1),obs,Electrod_positions)
%%
scatter3(X1Hist(2,:),X1Hist(3,:),X1Hist(4,:),'*')
hold on
scatter3(X2Hist(2,:),X2Hist(3,:),X2Hist(4,:),'*')
scatter3(Neuron_positions(2,1),Neuron_positions(3,1),Neuron_positions(4,1),'.')
scatter3(Neuron_positions(2,2),Neuron_positions(3,2),Neuron_positions(4,2),'.')
