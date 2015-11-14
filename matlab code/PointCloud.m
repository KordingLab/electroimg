D = AddPatches(Frec);
D1 = SmoothData(D,5,1);
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