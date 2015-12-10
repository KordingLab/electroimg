close
K = 4;
for K = 1:3:60
    imagesc(reshape(newData(K,:,:,4),100,125)+.00001*randn(100,125))
    hold on;
    pause
end
close
%%
Dis = pdist2([tree2.X,tree2.Y,tree2.Z],[ReconNeuron(1,:)-2;ReconNeuron(2,:)-2;ReconNeuron(3,:)]');
mean(min(Dis))
%%
dis_neu_rec = [];
count = 1;
I =  .1:.1:5;
for i = I
    [dvec,TP,FP,M,Matches] = centroiderror_missrates([tree2.X,tree2.Y,tree2.Z]',[ReconNeuron(1,:)-2;ReconNeuron(2,:)-2;ReconNeuron(3,:)],i);
    dis_neu_rec(count) = FP;
    count = count + 1;
end
plot(I,dis_neu_rec)
%%
C0 = pro;
C1 = neuron(:,1:3);
A = pdist2(C0,C1);

%%
plot3(neuron(:,3),neuron(:,2),neuron(:,1),'*');
hold on;
plot3(pro(:,1),pro(:,2),pro(:,3),'.r');
%%
pro(:,1) = 2*MaxPos(:,1)-62;
pro(:,2) = 2*MaxPos(:,2)-100;
pro(:,3) = 2*MaxPos(:,3)-150;
%%
A = randn(3,100);
B = A + .1*randn(3,100);
[dvec,TP,FP,M,Matches] = centroiderror_missrates(A,B,.15)
%%
for i = 1:278
    plot3(tree2.X(i),tree2.Y(i),tree2.Z(i),'.');
    hold on
    pause
end
%%
out = convn_fft(z,ones(3,3,3));
% imagesc(reshape(out(10,:,:),30,50))
[Maxima,MaxPos,Minima,MinPos]=MinimaMaxima3D(out,1,0);
plot3(MaxPos(:,1),MaxPos(:,2),MaxPos(:,3),'.')
%%
[MaxPos,MinPos] = MaxMinRecNeuron(squeeze(newData(:,:,:,3))+.0000004*randn(60,100,125),10,2);
plot3(MaxPos(:,1),MaxPos(:,2),MaxPos(:,3),'.')
%%
[a1,M1,b1,m1]=MinimaMaxima3D(F0,1,0);
[M2,m2] = MaxMinRecNeuron(Frec,2,2);
plot3(M1(:,1),M1(:,2),M1(:,3),'*');
hold on
plot3(M2(:,1),M2(:,2),M2(:,3),'.r');
%%
Distance = DisNeuRecNeu(M1',M2',0,6);
plot(Distance)
%%
for i = 1:30
    imagesc(squeeze(F0(i,:,:))-squeeze(Frec(i,:,:)))
    pause
end
%%
Index = MinMaxBox(squeeze(newData(:,:,:,3)),1);
[I,J,K] = ind2sub([60,100,125],find(Index==26));
plot3(I,J,K,'.')
%%
[MaxPosition,MinPosition] = Abs_Recon_Max_in_all_patches(Frec,.0007);
plot3(MaxPosition(:,1),MaxPosition(:,2),MaxPosition(:,3),'.')
%%
D1 = SmoothData(D,4,1);
I = find(D1>.00016);
[a,b,c] = ind2sub([60,100,125],I);
plot3(a,b,c,'.')
%%
D = AddPatches(Frec);
D1 = SmoothData(D,5,1);
%%
close
End1 = [];
End2 = [];
for i = 1:56
    i
    subplot(1,4,1)
    imagesc(squeeze(newData(i,:,:,20)))
    subplot(1,4,2)
    imagesc(squeeze(D1(i,:,:)))
    T = 1;
    r = 0;
    while(T==1)
        K = find(squeeze(D1(i,:,:))>r);
        r = r + .00002;
        P = size(K,1);
        if(P<50)
            T = 0;
        end
    end
    A = zeros(100,125);
    [a,b] = ind2sub([100,125],K);
    End1 = [End1;[i*ones(size(a,1),1),a,b]];
    for j = i:size(a,1)
        A(a(j),b(j)) = 1;
    end
    subplot(1,4,3)
    imagesc(A);
    T = 1;
    r = 0;
    while(T==1)
        K = find(squeeze(D1(i,:,:))<r);
        r = r - .00002;
        P = size(K,1);
        if(P<10)
            T = 0;
        end
    end
    A = zeros(100,125);
    [a,b] = ind2sub([100,125],K);
    End2 = [End2;[i*ones(size(a,1),1),a,b]];
    for j = i:size(a,1)
        A(a(j),b(j)) = 1;
    end
    subplot(1,4,4)
    imagesc(A);  
    pause
end
%close
%%
close
for i = 1:30
    subplot(1,3,1)
    imagesc(squeeze(newData(i,:,:,20)))
    subplot(1,3,2)
    imagesc(squeeze(D1(i,:,:)))
    
    K = find(squeeze(D1(i,:,:))>.0017);
    
    [a,b] = ind2sub([100,125],K);
    A = zeros(100,125);
    for j = i:size(a,1)
        A(a(j),b(j)) = 1;
    end
    subplot(1,3,3)
    imagesc(A);
    pause
end
%%
close
for i = 1:30
    
    subplot(1,3,1)
    imagesc(squeeze(newData(i,:,:,20)))
    subplot(1,3,2)
    imagesc(squeeze(D1(i,:,:)))
    options = statset('Display','final');
    D2 = squeeze(abs(D1(i,:,:)));
    D2 = D2/(sum(sum(D2)));
    obj = gmdistribution.fit(X,2,'Options',options);
    for j = i:size(a,1)
        A(a(j),b(j)) = 1;
    end
    subplot(1,3,3)
    imagesc(A);
    pause
end

%%
%D2 = max(D1(1:56,:,:),0);
D2 = abs(min(D1(1:56,:,:),0));
D2 = D2/(sum(sum(sum(D2))));
X = Field2Samp(D2,10000);
options = statset('Display','final');
obj = gmdistribution.fit(X,15,'Options',options);
point = obj.mu;
%%
%plot3(2*point(:,1)-150,2*point(:,2)-100,2*point(:,3)-60,'*r')
%hold on;
plot3(aa(:,3),aa(:,2),aa(:,1),'.')
%%
%D2 = squeeze(max(D1(35,:,:),0));
D2 = squeeze(abs(D1(15,:,:)));
%D2 = D2/(sum(sum(sum(D2))));
X = Field2Samp(D2,15000);
options = statset('Display','final');
obj = gmdistribution.fit(X,2,'Options',options);
point = obj.mu;
%%
subplot(1,2,1)
plot(2*point(:,2)-60,2*point(:,1)-50,'*r')
subplot(1,2,2)
imagesc(squeeze(newData(15,:,:,20)))
%%
close
End1 = [];
End2 = [];
for i = 1:56
    i
    subplot(1,2,1)
    imagesc(squeeze(newData(:,:,i,5)))
    subplot(1,2,2)
    imagesc(squeeze(D1(:,:,i)))
    pause
end