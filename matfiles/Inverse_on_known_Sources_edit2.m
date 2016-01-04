%% Structured Matrix
A = []; 
d1 = 40; % planar resulotion (x)
d2 = d1; % planar resulotion (y)
depth = .1; % Distance btw Source and recording plane
d = d1*d2; % Number of pixels 
a = (ones(d1,1)*[0:(d1-1)])/d1;
b = (a - a').^2;
Distance = depth.^2 +kron(b,ones(d2))+kron(ones(d2),b);
A = (Distance).^(-.5);
surf(reshape(A(:,580),d2,d1))
clear Distance a b
%% The random (position + amount) sources on source plane
N = 4; %% number of sources
neuron_data = [];

% Amount of sources
%neuron_data(1,:) = randn(1,N); % Gussian amounts
 neuron_data(1,:) = 1-2*floor(2*rand(1,N)); % Binary amounts

% x-y Position of sources
neuron_data(2,:) = rand(1,N);
neuron_data(3,:) = rand(1,N);
neuron_data(2,:) = floor(d1*neuron_data(2,:))/d1; % On the site of Sources plane
neuron_data(3,:) = floor(d2*neuron_data(3,:))/d2; % On the site of Sources plane

% z Position of sources
% neuron_data(4,:) = depth*rand(1,N); % Random depth
neuron_data(4,:) = depth*ones(1,N); % Fixed depth

%% Neuron Structure
load('NeuronStructure.mat')
X = tree2.X;
Y = tree2.Y;
Z = tree2.Z;
Ne = unique(floor(d1*[((X+145)/230)';((Y+65)/125)'])'/(d1), 'rows')';
% Ne = [((X+145)/230)';((Y+65)/125)'];
N = size(Ne,2);
neuron_data = [];
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
neuron_data(2:3,:) = Ne;
neuron_data(4,:) = depth*ones(1,N);
%neuron_data = [1-2*floor(2*rand(1,N));((X+145)/230)';((Y+65)/125)';depth*ones(1,size(X,1))];
%clear X Y Z Ne

%% Inverse with given proposed sources
Z = zeros(d1,d2);
I = floor(neuron_data(2,:)*d2)+1;
J = floor(neuron_data(3,:)*d1)+1;
for i = 1:N
        Z(J(i),I(i)) = neuron_data(1,i);
end
In = find(abs(filter2(ones(70),Z))>0);
%A_in = A(:,In);
%A_lest = (A_in'*A_in)^(-1)*(A_in');
clear A_in I J i
%% Evalution
[Xsim,Ysim] = meshgrid(0:1/d1:(d1-1)/d1,0:1/d2:(d2-1)/d2);
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = zeros(1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential(mesh,neuron_data);
D1 = reshape(D,d2,d1);
subplot(121)
imagesc(D1)
title('Recording')
subplot(122)
imagesc(Z)
title('Sources')
clear Xsim Ysim Zsim mesh 
%% Show Rec/Actu/Prop
border = 0;
D1 = reshape(D,d1,d2);
subplot(131)
imagesc(D1(border+1:end-border,border+1:end-border))
title('Recording')
subplot(132)
imagesc(Z(border+1:end-border,border+1:end-border)); %colormap(gray);
title('Actual Sources')
subplot(133)
%Dp = A_lest*D';
%Dprop = zeros(d1,d2);
%Dprop(In) = Dp;
%imagesc(Dprop(border+1:end-border,border+1:end-border))
Dprop2 = lsqlin(A,D,[],[]);
imagesc(reshape(Dprop2,d1,d2))
title('Proposed Sources')