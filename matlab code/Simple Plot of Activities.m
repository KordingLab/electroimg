%% On parallel line
% activity along each column are represented by a 1 dim plot and number of
% charges are shown by a spectrum in red to blue color.

close
N = 6; %% number of neurons
neuron_data = 1-2*rand(4,N);
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
d1 = 50; % columwise resulotionn
d2 = 5; % planar resulotion
[X,Y,Z] = meshgrid(-1:2/(d2-1):1,-1:2/(d2-1):1,-1:2/(d1-1):1);
d = d1*(d2^2);
X = reshape(X,1,d);
Y = reshape(Y,1,d);
Z = reshape(Z,1,d);
D = evalpotential([X;Y;Z],neuron_data);
D = reshape(D,d2,d2,d1);
Neuron = floor(d2*(neuron_data(3:-1:2,:)+1)/2)+1;
NeuronMinus = Neuron(:,find(neuron_data(1,:)==1));
NeuronPlus = Neuron(:,find(neuron_data(1,:)==-1));
Neuronminus = [d2 1]*NeuronMinus-d2;
Neuronplus = [d2 1]*NeuronPlus-d2;
clrmap = colormap ('jet');
for i = 1:d2
    for j = 1:d2
        subplot(d2,d2,d2*i+j-d2)
        plot(-1:2/(d1-1):1,reshape(D(i,j,:),1,d1),'k')
        intensplus = length(find(Neuronplus==i*d2+j-d2));
        intensminus = length(find(Neuronminus==i*d2+j-d2));
        I = intensplus-intensminus;
        axis([-1 1 -5-N/4 5+N/4])
        I = 5*I/N;
        I = min(.2,I);
        I = max(-.2,I);
        set(gca,'Color',[0.8-I 0.8 0.8]);     
    end
end
