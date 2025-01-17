%% Basis
A = []; % Structure Matrix
d1 = 50; % planar resulotion (x)
d2 = d1; % planar resulotion (y)
depth = .1;
d = d1*d2;
a = (ones(d1,1)*[0:d1-1])/d1;
b = (a - a').^2;
A = (depth.^2 +kron(b,ones(d2))+kron(ones(d2),b)).^(-.5);
imagesc(reshape(A(:,875),d2,d1))
%% The random data on sources plane
N = 100; %% number of sources
depth = .1;
neuron_data = [];
neuron_data(1,:) = randn(1,N);
neuron_data(2,:) = rand(1,N);
neuron_data(3,:) = rand(1,N);
neuron_data(4,:) = depth*rand(1,N);
neuron_data(4,:) = depth*ones(1,N);
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
%% On the site of Sources plane
v = zeros(d1,d2);
neuron_data = [];
N = 10;
for i = 1:N
    a1 = floor(d1*rand)+1;
    a2 = floor(d1*rand)+1;
    a3 = randn;
    v(a1,a2) = a3;
    neuron_data(1:4,end+1) = [a3,(a2-1)/(d1-1),(a1-1)/(d1-1),.1];
end
v = reshape(v,d,1);
D = (A*v)';
D1 = reshape(D,d2,d1);
imagesc(D1)
%% Neuron Structure
X = tree2.X;
Y = tree2.Y;
Z = tree2.Z;
N = size(X,1);
neuron_data = [1-2*floor(2*rand(1,N));((X+145)/230)';((Y+65)/125)';.1*ones(1,size(X,1))];
%neuron_data(2:3,:) = floor(d1*neuron_data(2:3,:))/(d1);
%% Evalution
[Xsim,Ysim] = meshgrid(0:1/d1:((d1-1)/d1),0:1/d1:((d1-1)/d1));
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = zeros(1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential(mesh,neuron_data);
D1 = reshape(D,d2,d1);
imagesc(D1)
%% L2 regularization (forward calculation)
%Ridg0 = A'*A;
lambda = 40;
%B = ((Ridg0-lambda*eye(d))^-1);
%B = ((Ridg0)-lambda*ones(d))^-1;
%B = A^-2;
B = A^-1;
%B = ((Ridg0))^-1;
surf(reshape(B(:,875),d2,d1))
%Ridg = lambda*Ridg1-(lambda^2)*Ridg2+(lambda^3)*Ridg3-(lambda^4)*Ridg4;
%surf(reshape(Ridg(:,210),d2,d1))
Dprop = B*(D');
%%
I = eig(A);
I = flip(sort(I));
%%
plot(I(1:100))
loglog(I)
%%
border = 0;
D1 = reshape(D,d2,d1);
subplot(131)
imagesc(D1(border+1:end-border,border+1:end-border))
subplot(132)
Z = zeros(d1,d2);
I = floor(neuron_data(2,:)*d2)+1;
J = floor(neuron_data(3,:)*d1)+1;
for i = 1:N
        Z(J(i),I(i)) = neuron_data(1,i);
end
imagesc(Z(border+1:end-border,border+1:end-border));%colormap(gray);
subplot(133)
Dprop = B*(D');
Dprop1 = reshape(Dprop,d2,d1);
imagesc(Dprop1(border+1:end-border,border+1:end-border))
%imagesc(Dprop1)
%subplot(144)
S = peakVally(Dprop1);
Z2 = zeros(d1,d2);
Z2(find(S==4)) = -1;
Z2(find(S==-4)) = 1;
th = zeros(d1,d2);
th(find(abs(Dprop1)>.008)) = 1;
Z2 = Z2.*th;
%imagesc(Z2(border+1:end-border,border+1:end-border))
%%
border = 10;
surf(Dprop1(border+1:end-border,border+1:end-border))
hold on
surf(Z(border+1:end-border,border+1:end-border)/.40)
%%
Dif = Z-Z2;
imagesc(Dif(12:end-12,12:end-12))
%% L2 regularization (gradient descent)

%% Proximal Gredient
epsilon = .001;
x = zeros(100,100);

