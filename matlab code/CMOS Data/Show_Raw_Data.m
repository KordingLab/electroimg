%% import Data
X = data.x;
Y = data.y;
Data = data.raw;
A = data.ave;
%% Matrix of 110*102
x1 = 160;
x2 = 1910;
y1 = 100;
y2 = 2100;
Xb = x1:(x2-x1)/109:x2;
Yb = y1:(y2-y1)/101:y2;
D = zeros(110,102,300);
s = [];
for i = 1:110
    for j = 1:102
        I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<900);
        if(size(I,2)<1)
            I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<900);
        end
        s(end+1) = size(I,2);
        % D(i,j,:) = mean(Data(25,I,:));
        D(i,j,:) = mean(A(I,:));
    end
end
%% Plot the Movie
%imshow(squeeze(D(:,:,200)))
%m = zeros(1,300);
close
for i = 31:300
    imagesc(fliplr(flipud(tanh(.1*squeeze(D(:,:,i))))))
  %  imagesc(fliplr(flipud(min(max((squeeze(D(:,:,i)/5).^3),-50),50))))
    %Del(:,:,i) = del2(squeeze(D(:,:,i)));
    colormap(gray)
    caxis([-1,1])
    %m(i) = mean(mean(squeeze(D(:,:,i))));
    pause(.05);
    i
end
%% Infering the Ssources
close
for i = 35:200
    %surf(squeeze(Del(:,:,i)))
    %axis([1 110 1 102 -350 350])
    
    surf(tanh(.15*squeeze(Del(:,:,i))))
    axis([1 110 1 102 -3 3])
    pause;
    i
end