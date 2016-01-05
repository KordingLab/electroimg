%% Structured Matrix
Xp = 0:.025:1; % planar resulotion (x)
Yp = Xp; % planar resulotion (y)
d = size(Xp,2)*size(Yp,2);
Xs = Xp;
Ys = Xp;
Zs = .06:.04:.14;
[A,B] = structured_matrix(Xp,Yp,Xs,Ys,Zs);
A_lest = pinv(B);
%% The random (position + amount) sources on source plane
N = 3; %% number of sources
neuron_data = [];
% neuron_data(1,:) = randn(1,N); % Gussian amounts
neuron_data(1,:) = 1-2*floor(2*rand(1,N)); % Binary amounts
neuron_data(2,:) = Xs(1+floor(rand(1,N)*size(Xs,2))); % On the site of Sources plane
neuron_data(3,:) = Ys(1+floor(rand(1,N)*size(Ys,2))); % On the site of Sources plane
neuron_data(4,:) = Zs(1+floor(rand(1,N)*size(Zs,2))); % Fixed depth
neuron_data(4,:) = .2;
% Evalution
[Xsim,Ysim] = meshgrid(Xp,Yp);
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = zeros(1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential(mesh,neuron_data);
D1 = reshape(D,size(Xp,2),size(Yp,2));
imagesc(flipud(D1))
%% Neuron Structure
load('NeuronStructure.mat')
X = tree2.X;
Y = tree2.Y;
Z = tree2.Z;
Ne = unique(floor(size(Xp,2)*[(X+145)/230,(Y+65)/125,.09+(Z+500)/15000])/(size(Xp,2)), 'rows')';
N = size(Ne,2);
neuron_data = [];
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
neuron_data(1,:) = 1;
neuron_data(1,:) = randn(1,N); % Gussian amounts
neuron_data(2:4,:) = Ne;
depth = .1;
neuron_data(4,:) = depth;
% Evalution
[Xsim,Ysim] = meshgrid(Xp,Yp);
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = zeros(1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential(mesh,neuron_data);
D1 = reshape(D,size(Xp,2),size(Yp,2));
clear X Y Z Ne
imagesc(flipud(D1))
%% Show Rec/Actu/Prop
border = 0;
D1 = reshape(D,size(Xp,2),size(Yp,2));
subplot(1,size(Zs,2)+2,1)
imagesc(flipud(D1(border+1:end-border,border+1:end-border)))
title('Recording for')
subplot(1,size(Zs,2)+2,2)
scatter(neuron_data(3,:),neuron_data(2,:)) %colormap(gray);
axis([0 1 0 1])
title('Actual Sources')
Dp = A_lest*D';
Dprop = reshape(Dp,size(Xs,2),size(Ys,2),size(Zs,2));
for i = 1:size(Zs,2)
    subplot(1,size(Zs,2)+2,i+2)
    imagesc(flipud(squeeze(Dprop(:,:,i))))
    title('Proposed Sources')
end
%% pinv on each plane
border = 0;
D1 = reshape(D,size(Xp,2),size(Yp,2));
subplot(1,5,1)
imagesc(flipud(D1(border+1:end-border,border+1:end-border)))
title('Recording')
subplot(1,5,2)
scatter(neuron_data(3,:),neuron_data(2,:)) %colormap(gray);
axis([0 1 0 1])
title('Actual Sources')
Xp = 0:.025:1; % planar resulotion (x)
Yp = Xp; % planar resulotion (y)
d = size(Xp,2)*size(Yp,2);
Xs = Xp;
Ys = Xp;
for i = 1:3
    Zs = i/20;
    [A,B] = structured_matrix(Xp,Yp,Xs,Ys,Zs);
    A_lest = pinv(B);
    Dp = A_lest*D';
    subplot(1,5,i+2)
    Dprop = reshape(Dp,size(Xs,2),size(Ys,2),size(Zs,2));
    imagesc(flipud(squeeze(Dprop(:,:,1))))
    title('Proposed Sources')
end