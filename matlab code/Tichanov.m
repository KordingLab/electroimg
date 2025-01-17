%% DIPOLE BASIS 
d1 = 110; % planar resulotion (x)
d2 = 102; % planar resulotion (y)
d = d1*d2;
[Xsim,Ysim,Zsim] = meshgrid(0:1/(d1-1):1,0:1/(d2-1):1,0);
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = reshape(Zsim,1,d);
mesh = [Xsim;Ysim;Zsim];
AA = [];
In = [];
count = 1;
for i = 1:5:d1
    for j = 1:5:d2
        for k = 1:5
            AA(:,end+1) = evalpotential(mesh,[[1;i/d1;j/d2;k/100],[-1;(i+5)/d1;j/d2;k/100]]);
            In(end+1,:) = [i;j;k;1];
            AA(:,end+1) = evalpotential(mesh,[[1;i/d1;j/d2;k/100],[-1;i/d1;(j+5)/d2;k/100]]);
            In(end+1,:) = [i;j;k;2];
            AA(:,end+1) = evalpotential(mesh,[[1;i/d1;j/d2;k/100],[-1;i/d1;j/d2;(k+1)/100]]);
            In(end+1,:) = [i;j;k;3];
            count = count + 1
        end
    end
end
%% REGULARE BASIS
d1 = 110; % planar resulotion (x)
d2 = 102; % planar resulotion (y)
d = d1*d2;
[Xsim,Ysim,Zsim] = meshgrid(0:1/(d1-1):1,0:1/(d2-1):1,0);
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = reshape(Zsim,1,d);
mesh = [Xsim;Ysim;Zsim];
AAA = [];
Inre = [];
count = 1;
for i = 1:5:d1
    for j = 1:5:d2
        for k = 1:5
            AAA(:,end+1) = evalpotential(mesh,[1;i/d1;j/d2;k/100]);
            Inre(end+1,:) = [i;j;k];
            count = count + 1
        end
    end
end
%%
so  = randn(size(AA,2),1).*floor(rand(size(AA,2),1)+.07);
%so = zeros(size(AA,2),1);so(1004) = 1;so(1014) = -1;
x = AA*so;
%x = zeros(size(AA,2),1); x(1000) = 1;x(2000) = -1;
%x = AA*x;
surf(reshape(x,d2,d1))
%%
x = reshape(conv2(data(:,:,68),fspecial('gaussian',4,3),'same')',d,1);
% K = zeros(4620,1);
% for i = 1:10
%     K(find(In(:,3)==i)) = 11-i;
% end
K = 1;
%bi = ridge(x-(sum(sum(x))/d),AA,K);
bre = ridge(x,AAA,50);
%%
subplot(121)
surf(reshape(x,d2,d1))
subplot(122)
surf(reshape(AAA*bre,d2,d1))
%%
subplot(131)
surf(reshape(x,d2,d1))
subplot(132)
surf(reshape(AAA*bre,d2,d1))
subplot(133)
%plot3(21,76,9,'.r');plot3(46,51,9,'.r');grid on;axis([1 d1 1 d2 1 10])
I = find(bre>.1);
plot3(Inre(I,1),Inre(I,2),Inre(I,3),'.r');grid on
hold on
I = find(bre<-.1);
plot3(Inre(I,1),Inre(I,2),Inre(I,3),'.b');grid on;axis([1 d1 1 d2 1 10])
