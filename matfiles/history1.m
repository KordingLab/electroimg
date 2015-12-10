close
lap = del2(D1,3);
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
        if(P<250)
            T = 0;
        end
    end
    A = zeros(100,125);
    [a,b] = ind2sub([100,125],K);
    for j = i:size(a,1)
        A(a(j),b(j)) = 1;
    end
    subplot(1,4,3)
    imagesc(A);
    A = zeros(100,125);
    [Grad1,Grad2] = gradient(squeeze(D1(i,:,:)));
    [Grad11,Grad12] = gradient(Grad1);
    [Grad21,Grad22] = gradient(Grad2);
    %lap = Grad11+Grad22;
    %      T = 1;
    %     r = 0;
    %     while(T==1)
    %         K = find(lap<r);
    %         r = r + .00002;
    %         P = size(K,1);
    %         if(P<50)
    %             T = 0;
    %         end
    %     end
    %      [a,b] = ind2sub([100,125],K);
    %     for j = i:size(a,1)
    %         A(a(j),b(j)) = 1;
    %     end
    subplot(1,4,4)
    imagesc(squeeze(lap(i,:,:)));
    pause
end
%%
[Grad1,Grad2,Grad3] = gradient(D1(:,:,:));
[Grad11,Grad12,Grad13] = gradient(Grad1);
[Grad21,Grad22,Grad23] = gradient(Grad2);
[Grad31,Grad32,Grad33] = gradient(Grad3);
% lap = Grad11+Grad22+Grad33;
lap = del2(D1(3:end-3,3:end-3,3:end-3),1);
T = 1;
r = 0;
while(T==1)
    K = find(lap<r);
    r = r - .000005;
    P = size(K,1);
    if(P<3000)
        T = 0;
    end
end
A = zeros(60,100,125);
[a,b,c] = ind2sub([60-5,100-5,125-5],K);
T = 1;
r = 0;
while(T==1)
    K = find(lap>r);
    r = r + .000005;
    P = size(K,1);
    if(P<300)
        T = 0;
    end
end
A = zeros(60,100,125);
[a2,b2,c2] = ind2sub([60-5,100-5,125-5],K);

scatter3(2*a-60,2*b-100,2*c-150,'.r')
hold on;
scatter3(aa(:,3),aa(:,2),aa(:,1),'.k')
scatter3(2*a2-60,2*b2-100,2*c2-150,'.b')
%%
lap = del2(D1,5);
for i = 1:60
    imagesc(squeeze(lap(i,:,:)));
    pause
end
%%
Distance = DisNeuRecNeu(aa',[2*a-60,2*b-100,2*c-150]',0,30);