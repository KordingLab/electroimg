%% iterative method without Next Vector function

clc
clear
Neuron_positions = 1-2*rand(4,2);
Electrod_positions = 1-2*rand(3,20);
obs = evalpotential(Electrod_positions,Neuron_positions);
Xstart = 1-2*rand(8,1); % Strating point

X1Histall = []; % History of X1 (first charge, during the iterations)
X2Histall = []; % History of X2 (first charge, during the iterations)
P = []; % to choose the closest point in # sample
options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
X1Hist=zeros(4,1);
X2Hist=zeros(4,1);
for j = 1:9
    Xstart = 1-2*rand(8,1);
for i = 1:6
fx1 = @(x)pointchargefn1(x,Xstart(5:8),obs,Electrod_positions);
X1 = fminunc(fx1,Xstart(1:4),options);
fx2 = @(x)pointchargefn2(x,X1,obs,Electrod_positions);
X2 = fminunc(fx2,Xstart(5:8),options);
Xstart = [X1;X2];
X1Hist(:,i) = X1;
X1Histall(:,j,i) = X1;
X2Hist(:,i) = X2;
X2Histall(:,j,i) = X2;
end
j/24
P(j) = pointchargefn(Xstart,obs,Electrod_positions);
end
[jj,j] = min(P);
%Plot
%P(j)
scatter3(X1Histall(2,j,:),X1Histall(3,j,:),X1Histall(4,j,:),'*')
hold on

scatter3(X2Histall(2,j,:),X2Histall(3,j,:),X2Histall(4,j,:),'*')
scatter3(Neuron_positions(2,1),Neuron_positions(3,1),Neuron_positions(4,1),'.')
scatter3(Neuron_positions(2,2),Neuron_positions(3,2),Neuron_positions(4,2),'.')
legend('App of 1st point in each iteration','App of 2nd point in each iteration','1st point','2nd point')
%% Showing Next iterations (in the case it trapped in local minimuma)
Xstart = [X1Histall(:,j,4);X2Histall(:,j,4)];
%
X1Hist = [];
X2Hist =[];
for i = 1:20
fx1 = @(x)pointchargefn1(x,Xstart(5:8),obs,Electrod_positions);
[X1,FVAL] = fminunc(fx1,Xstart(1:4),options);
fx2 = @(x)pointchargefn2(x,X1,obs,Electrod_positions);
[X2,FVAL] = fminunc(fx2,Xstart(5:8),options);
Xstart = [X1;X2];
X1Hist(:,i) = X1;
X2Hist(:,i) = X2;
end
%
scatter3(X1Hist(2,:),X1Hist(3,:),X1Hist(4,:),'*')
hold on
scatter3(X2Hist(2,:),X2Hist(3,:),X2Hist(4,:),'*')
scatter3(Neuron_positions(2,1),Neuron_positions(3,1),Neuron_positions(4,1),'.')
scatter3(Neuron_positions(2,2),Neuron_positions(3,2),Neuron_positions(4,2),'.')
pointchargefn(Xstart,obs,Electrod_positions)
%% Position of electrods and point charges
scatter3(Neuron_positions(2,1),Neuron_positions(3,1),Neuron_positions(4,1),'.')
hold on;
scatter3(Neuron_positions(2,2),Neuron_positions(3,2),Neuron_positions(4,2),'.')
scatter3(Electrod_positions(1,:),Electrod_positions(2,:),Electrod_positions(3,:))
%% Using Next Vector function for more than 2 charges

clc
clear
Neuron_positions = 1-2*rand(4,2);
Electrod_positions = 1-2*rand(3,20);
obs = evalpotential(Electrod_positions,Neuron_positions);
Hist = []; % History of X1 (first charge, during the iterations)
P = []; % to choose the closest point in # sample
options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
for j = 1:3
    Xstart = 1-2*rand(4,2); % Strating point
for i = 1:10 
    Hist(:,:,j,i) = Xstart;
    Xstart = NextVector(Xstart,obs,Electrod_positions,options);
end
j/24;
P(j) = pointchargefn(Xstart,obs,Electrod_positions);
end
[jj,j] = min(P)

for k = 1:2
scatter3(Hist(2,k,j,:),Hist(3,k,j,:),Hist(4,k,j,:),'*')
hold on
end

scatter3(Neuron_positions(2,1),Neuron_positions(3,1),Neuron_positions(4,1),'.')
scatter3(Neuron_positions(2,2),Neuron_positions(3,2),Neuron_positions(4,2),'.')
