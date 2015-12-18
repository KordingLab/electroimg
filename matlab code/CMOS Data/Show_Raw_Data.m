%% import Data
X = data.x;
Y = data.y;
Data = data.raw;
A = data.ave;
I = [find(X==0),find(Y ==-1)];
X(I) = [];
Y(I) = [];
A(I,:) = [];
Data(:,I,:) = [];
clear data I
%% Average over Stimuluses
Ave=[]
for i = 1:11016
    Ave(end+1,:) = mean(squeeze(Data(:,i,:)));
end
%% Matrix of 110*102
x1 = 160;
x2 = 1910;
y1 = 100;
y2 = 2100;
Xb = x1:(x2-x1)/109:x2;
Yb = y1:(y2-y1)/101:y2;
data = zeros(110,102,300);
s = [];
for i = 1:110
    for j = 1:102
        I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<800);
        if(size(I,2)<1)
            I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<900);
        end
        s(end+1) = size(I,2);
        %data(i,j,:) = mean(Data(10,I,:));
        data(i,j,:) = mean(A(I,:));
        %data(i,j,:) = mean(Ave(I,:));
    end
end
%% Plot the Movie
%imshow(squeeze(D(:,:,200)))
%m = zeros(1,300);
close
for i = 31:300
    i
    imagesc(fliplr(flipud(tanh(.10*data(:,:,i)))))
    %surf(fliplr(flipud(tanh(.10*data(:,:,i)))))
    
    %  imagesc(fliplr(flipud(min(max((squeeze(data(:,:,i)/5).^3),-50),50))))
    %Del(:,:,i) = del2(squeeze(data(:,:,i)));
    colormap(gray)
    caxis([-1,1])
    %m(i) = mean(mean(squeeze(data(:,:,i))));
    pause;
end
%% Infering the Sources
close
for i = 35:200 
    %surf(squeeze(Del(:,:,i)))
    %axis([1 110 1 102 -350 350])
    surf(fliplr(flipud(squeeze(data(:,:,i)))))
    %imagesc(fliplr(flipud(squeeze(data(:,:,i)))))
    %colormap(gray)
    %surf(tanh(.15*squeeze(Del(:,:,i))))
    %imagesc(tanh(.10*squeeze(data(:,:,i))))
    %axis([1 110 1 102 -150 150])
    pause;
    i
end
%% Real Data (without Filter)
close
for i = 32:300
surf(fliplr(flipud(data(:,:,i))));%colormap(gray)
axis([1 110 1 102 -105 105])
pause
end
%% Level Sets
i = 50;
a = find(fliplr(flipud(data(:,:,i)))>.5);
Z = zeros(d1,d2);
Z(a) = 1;
imagesc(Z)
colormap(gray);
figure;
imagesc(fliplr(flipud(data(:,:,i))));colormap(gray)
%% FFT
i = 200;
F1 = fftn(fliplr(flipud(data(:,:,i))));
I = abs(F1);
C = flip(sort(reshape(I,d,1)));
plot(C(2:200))