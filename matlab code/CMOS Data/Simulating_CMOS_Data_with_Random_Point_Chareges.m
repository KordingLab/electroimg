%% On parallel line
% activitYsim along each column are represented bYsim a 1 dim plot and number of
% charges are shown bYsim a spectrum in red to blue color.
% clear
close
N = 500; %% number of neurons
depth = .2;
neuron_data = rand(4,N);
neuron_data(4,:) = depth*rand(1,N);

%neuron_data(1,:) = 1*(1-2*floor(2*rand(1,N)));

% Different Distribution
%neuron_data(1,:) = sign(randn(1,N)).*abs(randn(1,N)).^.5; 
neuron_data(1,:) = randn(1,N);

% Binary Charges
%neuron_data(1,:) = 1-2*rand(1,N);

% Dipole Model
% neuron_data(:,floor(N/2)+1:N) = neuron_data(:,1:floor(N/2))+.00001*randn(4,floor(N/2));
% neuron_data(1,floor(N/2)+1:N) = -neuron_data(1,1:floor(N/2));

% line Molde
lenght = 20;
for i = 1:N
    r = .001*randn(4,1);
    neuron_data(:,end+1:end+lenght) = neuron_data(:,i)*ones(1,lenght)+r*[1:lenght];
    neuron_data(1,end-lenght+1:end) = neuron_data(1,i)*ones(1,lenght);
end
%%
d1 = 110; % planar resulotion (x)
d2 = 102; % planar resulotion (y)
[Xsim,Ysim,Zsim] = meshgrid(0:1/(d1-1):1,0:1/(d2-1):1,0);
d = d1*d2;
Xsim = reshape(Xsim,1,d); 
Ysim = reshape(Ysim,1,d);
Zsim = reshape(Zsim,1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential(mesh,neuron_data);
D = reshape(D,d2,d1);
% Neuron(1,:) = floor(d1*(neuron_data(2,:)+1))+1;
% Neuron(2,:) = floor(d2*(neuron_data(3,:)+1))+1;
% NeuronMinus = Neuron(:,find(neuron_data(1,:)==1));
% NeuronPlus = Neuron(:,find(neuron_data(1,:)==-1));
% Neuronminus = [d2 1]*NeuronMinus-d2;
% Neuronplus = [d2 1]*NeuronPlus-d2;
imagesc(D)
colormap(gray)
%%
subplot(121)
imagesc(D)
colormap(gray)
subplot(122)
imagesc(squeeze(data(:,:,100))')
colormap(gray)
%% Plot
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
%plot3(guess(2,:),guess(3,:),guess(4,:),'.','color','r')
grid on
%%
subplot(121)
surf(D)
subplot(122)
surf(-B)
%% Max dels
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
B = del2(D);
A = abs(B);
ran = flip(sort(reshape(A,d1*d2,1)));
r = ran(2);
[Xloc,Yloc] = ind2sub([d2,d1],find(A > r));
p1 = [(Xloc-((d1+1)/2))/((d1-1)/2),(Yloc-((d2+1)/2))/((d2-1)/2)];
s = sign(B(Xloc,Yloc));
I = find(sum((mesh-p1'*ones(1,d)).^2)<.3^2);
fun = @(x)(sum((evalpotential([Xsim(I);Ysim(I);Zsim(I)],[x(1);x(2);x(3);x(4)])-D(I)).^2));
p = fminsearch(fun,p1);
if(abs(p(1))<10)
plot3(pmin(1),pmin(2),pmin(3),'.','color','r')
end
grid on
%plot3((Ysim-((d2+1)/2))/((d2-1)/2),(Xsim-((d2+1)/2))/((d2-1)/2),(Zsim-((d1+1)/2))/((d1-1)/2),'.','color','r')
%    plot3(Ysim/50,Xsim/50,Zsim/50,'.','color','r')
%% Min/MaXsim algorithm
guess = [];
D1 = D;
for i = 1:3
    B = del2(D1);
A = abs(B);
ran = flip(sort(reshape(A,d1*d2^2,1)));
r = ran(2);
[Xsim,Ysim,Zsim] = ind2sub([d2,d2,d1],find(A > r));
p1 = [(Ysim-((d2+1)/2))/((d2-1)/2),(Xsim-((d2+1)/2))/((d2-1)/2),(Zsim-((d1+1)/2))/((d1-1)/2)];
s = sign(B(Xsim,Ysim,Zsim));
I = find(sum((mesh-p1'*ones(1,d)).^2)<.4^2);
funmaXsim = @(Xsim)(sum((evalpotential([Xsim(I);Ysim(I);Zsim(I)],[1;Xsim(1);Xsim(2);Xsim(3)])-D(I)).^2));
pmaXsim = fminsearch(funmaXsim,p1);
funmin = @(Xsim)(sum((evalpotential([Xsim(I);Ysim(I);Zsim(I)],[-1;Xsim(1);Xsim(2);Xsim(3)])-D(I)).^2));
pmin = fminsearch(funmin,p1);
if(abs(pmin(1))<10)
    guess(:,end+1) = [-1,pmin]';
end
if(abs(pmaXsim(1))<10)
    guess(:,end+1) = [1,pmaXsim]';
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
%% Plot MaXsim dels
plot3(neuron_data(2,:),neuron_data(3,:),neuron_data(4,:),'.')
hold on
B = del2(D);
A = abs(B);
s = flip(sort(reshape(A,d1*d2^2,1)));
r = s(N+1);
[Xsim,Ysim,Zsim] = ind2sub([d2,d2,d1],find(A > r));
p1 = [(Ysim-((d2+1)/2))/((d2-1)/2),(Xsim-((d2+1)/2))/((d2-1)/2),(Zsim-((d1+1)/2))/((d1-1)/2)];
plot3((Ysim-((d2+1)/2))/((d2-1)/2),(Xsim-((d2+1)/2))/((d2-1)/2),(Zsim-((d1+1)/2))/((d1-1)/2),'.','color','r')
%    plot3(Ysim/50,Xsim/50,Zsim/50,'.','color','r')
%% Plot del
for i = 1:d1
imagesc(squeeZsime(A(:,:,i)))
pause
end
    %% in one slice
for i = 1:d1
    I = find(abs(neuron_data(4,:)-(2*(i/d1)-1))<(2/d1));
    Zsim = Zsimeros(d2,d2);
    for j = 1:siZsime(I,2)
        Zsim(Neuron(1,j),Neuron(2,j))=1;
        i
    end
    subplot(1,2,1)
    imagesc(squeeZsime(D(:,:,i)))
    subplot(1,2,2)
    imagesc(Zsim)
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
        aXsimis([-1 1 -5-1.5*sqrt(N) 5+1.5*sqrt(N)])
        I = 5*I/N;
        I = min(.2,I);
        I = maXsim(-.2,I);
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
Zsim = Zsimeros(siZsime(F1));
for i = 1:T-2
Zsim(J(i)) = F1(J(i));
end
R = ifftn(Zsim);
%
A = del2(R,1);
for i = 1:d1
        subplot(1,3,1)
    imagesc(squeeZsime(D(:,:,i)))
    subplot(1,3,2)
    imagesc(squeeZsime(abs(R(:,:,i))))
    subplot(1,3,3)
    imagesc(squeeZsime(abs(A(3:end-3,3:end-3:,i))))
    pause
end
close
%% Code to find the structure
% Find the candidate for point charges
close
for i = 71:150
    i
 %imagesc(conv2(data(:,:,i),fspecial('gaussian',1,1),'same'));caxis([-10,10]);colormap(gray)
    % imagesc(conv2(data(:,:,i),fspecial('gaussian',1,3),'same'));caxis([-15,15])
    % imagesc(data(:,:,i));caxis([-5,5])
     surf(del2(conv2(data(:,:,i),fspecial('gaussian',5,1),'same')));axis([1 110 1 102 -15 15])
%      [a b] = ind2sub([d1,d2], find(conv2(data(:,:,i),fspecial('gaussian',5,1),'same')>1.5));plot(a,b,'.');axis([0 d1 0 d2])
%      hold on
%      [a b] = ind2sub([d1,d2], find(conv2(data(:,:,i),fspecial('gaussian',5,1),'same')<-1.5));plot(a,b,'.r');axis([0 d1 0 d2])
%      hold off
    % Z = zeros(d1,d2); Z(find(abs(conv2(data(:,:,i),fspecial('gaussian',5,1),'same'))>3))=1;imagesc(Z)
    %colormap(gray)
    pause;
    
end
%%
[a b] = ind2sub([d1,d2], find(del2(conv2(data(:,:,87),fspecial('gaussian',5,1),'same'))>.5));plot(a,b,'.')
%% Mixture of Gaussian
for i = 31:135;
[a b] = ind2sub([d1,d2], find(del2(conv2(data(:,:,i),fspecial('gaussian',5,1),'same'))>.3));
plot(b,a,'.'); axis([1,d1,1,d2])
hold on
[a b] = ind2sub([d1,d2], find(del2(conv2(data(:,:,i),fspecial('gaussian',5,1),'same'))<-.5));
plot(b,a,'.r'); axis([1,d1,1,d2])
hold off
%figure 
%imagesc(flipud(conv2(data(:,:,i),fspecial('gaussian',1,3),'same')));caxis([-15,15])
%close
pause
end
%%
hold on
Z = [a,b];
options = statset('Display','final');
obj = gmdistribution.fit(Z,3,'Options',options);
h = ezcontour(@(x,y)pdf(obj,[x y]),[1 d1],[1 d2]);
