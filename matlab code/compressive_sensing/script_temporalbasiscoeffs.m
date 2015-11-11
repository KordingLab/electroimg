load DataTest

Ys = Y(20:50,10:30,10:30,1:150);

count=1; 
for i=1:size(Ys,1); 
    for j=1:size(Ys,2); 
        for k=1:size(Ys,3); 
            Data(count,:) = squeeze(Ys(i,j,k,:)); 
            count = count+1; 
        end 
    end 
end

numsamp = 5000;
numT = 150;
numPC = 10;
[U,S,V] = svds(Data(randi(size(Data,1),numsamp,1),1:numT),numPC);

% compute coefficients

coef = normc(Data')'*V(:,1);
count=1; 
for i =1:31; 
    for j=1:21; 
        for k=1:21; 
            C(i,j,k) = coef(count); 
            count=count+1; 
        end 
    end 
end

% visualize coefficients
figure; 
for i=1:21 
    subplot(1,2,1); 
    imagesc(Ys(:,:,i,10)), 
    subplot(1,2,2); 
    imagesc(C(:,:,i)); 
    pause, 
end





