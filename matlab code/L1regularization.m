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
J1 = find((X-900).^2+(Y-1100).^2<600^2);
J2 = find((X-900).^2+(Y-1100).^2<150^2);
data = squeeze(Data(1,J1,60))';
B = spg_bpdn(100*A_st(J1,J2), data, norm(data)*0.8, opts);
%% 3d plot
tri2 = delaunay(X(J2),Y(J2));
close
    subplot(1,2,1)
trisurf(tri2, X(J2), Y(J2), squeeze(Data(1,J2,60))');
view([0,0,1])
    subplot(1,2,2)
trisurf(tri2, X(J2), Y(J2), B);
view([0,0,1])
%% overtime
J1 = find((X-900).^2+(Y-1100).^2<600^2);
J2 = find((X-900).^2+(Y-1100).^2<200^2);
opts = spgSetParms('verbosity',0);
for i = 30:100
B(:,i) = spg_bpdn(100*A_st(J1,J2), squeeze(Data(12,J1,i))', .001, opts);i
end
tri2 = delaunay(X(J2),Y(J2));
%data = Data(12,J2,:);
for i = 31:100
subplot(121)
    trisurf(tri2, X(J2), Y(J2), squeeze(data(1,:,i)));
    view([0,0,1])
subplot(122)
    trisurf(tri2, X(J2), Y(J2), B(:,i));
    view([0,0,1])
    pause
end