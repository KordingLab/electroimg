%D = AddPatches(Frec);
D = squeeze(newData(:,:,:,15));
D1 = SmoothData(D,5,1);
lap = del2(D1(3:end-3,3:end-3,3:end-3),1);
T = 1;
r = 0;
while(T==1)
    K = find(lap<r);
    r = r - .000005;
    P = size(K,1);
<<<<<<< Updated upstream
    if(P<3000)
=======
    if(P<2600)
>>>>>>> Stashed changes
        T = 0;
    end
end
A = zeros(60,100,125);
[a,b,c] = ind2sub([60-5,100-5,125-5],K);
T = 1;
r1 = .0004;
while(T==1)
    K = find(lap>r1);
    r1 = r1 + .000005;
    P = size(K,1);
    if(P<300)
        T = 0;
    end
end
A = zeros(60,100,125);
[a2,b2,c2] = ind2sub([60-5,100-5,125-5],K);
scatter3(aa(:,3),aa(:,2),aa(:,1),'.k')
hold on;
scatter3(2*a2-60,2*b2-100,2*c2-150,'.b')
hold on;
<<<<<<< Updated upstream
scatter3(2*a-60,2*b-100,2*c-150,400*ones(1,size(a,1)),'.r')
scatter3(neuron(:,3),neuron(:,2),neuron(:,1),'.c')
=======
scatter3(2*a-60,2*b-100,2*c-150,500*ones(1,size(a,1)),'.r')
%scatter3(neuron(:,3),neuron(:,2),neuron(:,1),'.c')
>>>>>>> Stashed changes
%legend('Pyramidal Neuron','Positive sources(soma)','Negetive sources(body)');
%set(gca,'fontsize',18)