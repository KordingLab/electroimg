%% On parallel line
% activity along each column are represented by a 1 dim plot and number of
% charges are shown by a spectrum in red to blue color.
clear
close
N = 100; %% number of neurons
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
%% Min/Max algorithm
guess = [];
D1 = D;
for i = 1:5
    A = del2(D1);
    [x,y,z] = ind2sub([d2,d2,d1],find(A == max(max(max(A)))));
    guess(:,end+1) = [sign(A(x,y,z));(x-((d2+1)/2))/((d2-1)/2);...
        (y-((d2+1)/2))/((d2-1)/2);(z-((d1+1)/2))/((d1-1)/2)];
    Din = evalpotential(mesh,guess);
    Din = reshape(Din,d2,d2,d1);
    D1 = D1-Din;
end
%% Plot
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
plot3(guess(2,:),guess(3,:),guess(4,:),'.','color','r')
%% Max dels
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
B = del2(D);
A = abs(B);
ran = flip(sort(reshape(A,d1*d2^2,1)));
r = ran(2);
[x,y,z] = ind2sub([d2,d2,d1],find(A > r));
p1 = [(y-((d2+1)/2))/((d2-1)/2),(x-((d2+1)/2))/((d2-1)/2),(z-((d1+1)/2))/((d1-1)/2)];
s = sign(B(x,y,z));
I = find(sum((mesh-p1'*ones(1,d)).^2)<.3^2);
funmax = @(x)(sum((evalpotential([X(I);Y(I);Z(I)],[1;x(1);x(2);x(3)])-D(I)).^2));
pmax = fminsearch(funmax,p1)
funmin = @(x)(sum((evalpotential([X(I);Y(I);Z(I)],[-1;x(1);x(2);x(3)])-D(I)).^2));
pmin = fminsearch(funmin,p1)
if(abs(pmin(1))<10)
plot3(pmin(1),pmin(2),pmin(3),'.','color','r')
end
if(abs(pmax(1))<10)
plot3(pmax(1),pmax(2),pmax(3),'.','color','r')
end
plot3(p1(1),p1(2),p1(3),'.','color','k')
grid on
%plot3((y-((d2+1)/2))/((d2-1)/2),(x-((d2+1)/2))/((d2-1)/2),(z-((d1+1)/2))/((d1-1)/2),'.','color','r')
%    plot3(y/50,x/50,z/50,'.','color','r')
%% Min/Max algorithm
guess = [];
D1 = D;
for i = 1:3
    B = del2(D1);
A = abs(B);
ran = flip(sort(reshape(A,d1*d2^2,1)));
r = ran(2);
[x,y,z] = ind2sub([d2,d2,d1],find(A > r));
p1 = [(y-((d2+1)/2))/((d2-1)/2),(x-((d2+1)/2))/((d2-1)/2),(z-((d1+1)/2))/((d1-1)/2)];
s = sign(B(x,y,z));
I = find(sum((mesh-p1'*ones(1,d)).^2)<.4^2);
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
    Din = evalpotential(mesh,guess);
    Din = reshape(Din,d2,d2,d1);
    D1 = D-Din;
end
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
plot3(guess(2,:),guess(3,:),guess(4,:),'.','color','k')
grid on
guess
neuron_data
%% Plot Max dels
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
B = del2(D);
A = abs(B);
s = flip(sort(reshape(A,d1*d2^2,1)));
r = s(N+1);
[x,y,z] = ind2sub([d2,d2,d1],find(A > r));
p1 = [(y-((d2+1)/2))/((d2-1)/2),(x-((d2+1)/2))/((d2-1)/2),(z-((d1+1)/2))/((d1-1)/2)];
plot3((y-((d2+1)/2))/((d2-1)/2),(x-((d2+1)/2))/((d2-1)/2),(z-((d1+1)/2))/((d1-1)/2),'.','color','r')
%    plot3(y/50,x/50,z/50,'.','color','r')
%% Plot del
for i = 1:d1
imagesc(squeeze(A(:,:,i)))
pause
end
    %% in one slice
for i = 1:d1
    I = find(abs(neuron_data(4,:)-(2*(i/d1)-1))<(2/d1));
    Z = zeros(d2,d2);
    for j = 1:size(I,2)
        Z(Neuron(1,j),Neuron(2,j))=1;
        i
    end
    subplot(1,2,1)
    imagesc(squeeze(D(:,:,i)))
    subplot(1,2,2)
    imagesc(Z)
    pause
end
close
%%
clrmap = colormap ('jet');
for i = 1:d2
    for j = 1:d2
        subplot(d2,d2,d2*i+j-d2)
        plot(-1:2/(d1-1):1,reshape(D(i,j,:),1,d1),'k')
        intensplus = length(find(Neuronplus==i*d2+j-d2));
        intensminus = length(find(Neuronminus==i*d2+j-d2));
        I = intensplus-intensminus;
        axis([-1 1 -5-1.5*sqrt(N) 5+1.5*sqrt(N)])
        I = 5*I/N;
        I = min(.2,I);
        I = max(-.2,I);
        set(gca,'Color',[0.8-I 0.8 0.8]);
    end
end
%% looking at fft
F = abs(fftn(D));
Co = flip(sort(reshape(F,d,1)));
plot(Co(1:300))
%% looking at fft
close
T = 1000;
F1 = fftn(D);
I = abs(F1);
C = flip(sort(reshape(I,d,1)));
J = find(I>C(T));
z = zeros(size(F1));
for i = 1:T-2
z(J(i)) = F1(J(i));
end
R = ifftn(z);
%
A = del2(R,1);
for i = 1:d1
        subplot(1,3,1)
    imagesc(squeeze(D(:,:,i)))
    subplot(1,3,2)
    imagesc(squeeze(abs(R(:,:,i))))
    subplot(1,3,3)
    imagesc(squeeze(abs(A(3:end-3,3:end-3:,i))))
    pause
end
close
