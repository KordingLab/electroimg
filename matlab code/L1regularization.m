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
%% The Distance Matrix for depth = 10;
Dis = pdist([X;Y]');
s = 1;
Distance = zeros(size(X,2),size(X,2));
for i = 1:size(X,2)
   Distance(i,i+1:size(X,2)) = Dis(s:s+(size(X,2)-i-1));
   s = s + (size(X,2)-i);
end
Distance = Distance + Distance';
clear Dis
A_st = (Distance.^2+10^2).^-.5;
%% L1 data
opts = spgSetParms('verbosity',0);
J = find((X-900).^2+(Y-1100).^2<400^2);
data = squeeze(Data(12,J,60))';
B = spg_bpdn(A_st(J,J), data, .01, opts);
%% over the grids
x1 = 160;
x2 = 1910;
y1 = 100;
y2 = 2100;
Xb = x1:(x2-x1)/109:x2;
Yb = y1:(y2-y1)/101:y2;
%data = zeros(110,102,300);
L1_image_data = zeros(110,102);
main_image_data = zeros(110,102);
for i = 1:110
    for j = 1:102
        I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<800);
        if(size(I,2)<1)
            I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<900);
        end
 %       data(i,j,:) = mean(A(I,:));
        L1_image_data(i,j) = mean(B(find(ismember(I,J)==1),:));
        main_image_data(i,j) = mean(data(find(ismember(I,J)==1),:));
    end
end
clear x1 x2 y1 y2 Xb Yb i j I
main_image_data(find(isnan(main_image_data)==1)) = 0;
L1_image_data(find(isnan(L1_image_data)==1)) = 0;
%% 2d plot
close
    subplot(1,2,1)
    imagesc(fliplr(flipud(main_image_data)))
    title('Original Field')
    subplot(1,2,2)
    imagesc(fliplr(flipud(L1_image_data(:,:))))
    title('L1 regularization with error .01')
%% 3d plot
tri = delaunay(X(J),Y(J));
close
    subplot(1,2,1)
h = trisurf(tri, X(J), Y(J), data);
    subplot(1,2,2)
h = trisurf(tri, X(J), Y(J), B);
