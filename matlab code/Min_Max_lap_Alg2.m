%% On parallel line
% activity along each column are represented by a 1 dim plot and number of
% charges are shown by a spectrum in red to blue color.
clear
close
clc
N = 10; %% number of neurons
neuron_data = 1-2*rand(4,N);
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
d1 = 10; % columwise resulotionn
d2 = 10; % planar resulotion
[X,Y,Z] = meshgrid(-1:2/(d2-1):1,-1:2/(d2-1):1,-1:2/(d1-1):1);
d = d1*(d2^2);
X = reshape(X,1,d);
Y = reshape(Y,1,d);
Z = reshape(Z,1,d);
mesh = [X;Y;Z];
D = evalpotential(mesh,neuron_data);
D = reshape(D,d2,d2,d1);
Neuron = floor(d2*(neuron_data(3:-1:2,:)+1)/2)+1;
NeuronMinus = Neuron(:,find(neuron_data(1,:)==1));
NeuronPlus = Neuron(:,find(neuron_data(1,:)==-1));
Neuronminus = [d2 1]*NeuronMinus-d2;
Neuronplus = [d2 1]*NeuronPlus-d2;

guess = [];
D1 = D;
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'r*')
hold on
Index = [];
for i = 1:N
    
    B = del2(D1);
    A = abs(B);
    A(Index) = 0;
    ran = flip(sort(reshape(A,d1*d2^2,1)));
    r = ran(2);
    [x,y,z] = ind2sub([d2,d2,d1],find(A > r));
    p1 = [(y-((d2+1)/2))/((d2-1)/2),(x-((d2+1)/2))/((d2-1)/2),(z-((d1+1)/2))/((d1-1)/2)];
    s = sign(B(x,y,z));
    I = find(sum((mesh-p1'*ones(1,d)).^2)<.5^2);
    %guess(:,end+1) = [s,p1]'
    Index = [Index , I];
    funmax = @(x)(sum((evalpotential([X(I);Y(I);Z(I)],[1;x(1);x(2);x(3)])-D(I)).^2));
    pmax = fminsearch(funmax,p1);
    funmin = @(x)(sum((evalpotential([X(I);Y(I);Z(I)],[-1;x(1);x(2);x(3)])-D(I)).^2));
    pmin = fminsearch(funmin,p1);
    if(abs(pmin(1))<10)
        guess(:,end+1) = [-1,pmin]';
    end
    if(abs(pmax(1))<10)
        guess(:,end+1) = [1,pmax]';
    end
    % if we want to adjust the values again
    %funadj = @(x)(sum((evalpotential([X(Index);Y(Index);Z(Index)],[guess(1,:);x])-D(Index)).^2));
    %P = fminsearch(funadj,guess(2:4,:));
    %guess = [guess(1,:);P];
    %
    Din = evalpotential(mesh,guess);
    Din = reshape(Din,d2,d2,d1);
    D1 = D-Din;
    plot3(guess(2,i),guess(3,i),guess(4,i),'k*')
    text(guess(2,i),guess(3,i),guess(4,i),num2str(i),'FontSize',24 );
end
% plot3(guess(2,:),guess(3,:),guess(4,:),'.','color','k')
grid on
%guess
%neuron_data
%%
DD = evalpotential(mesh,[neuron_data, [-guess(1,1:2);guess(2:4,1:2)]]);
DD = reshape(DD,d2,d2,d1);
for i = 1:d1
    imagesc(squeeze(DD(:,:,i)))
    pause
end
%%
for i = 1:d1
    imagesc(squeeze(D(:,:,i)))
    pause
end
%%
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'r*')
hold on;
[x,y,z] = find(D==max(max(max(D))));
 = ind2sub([d2,d2,d1],);
