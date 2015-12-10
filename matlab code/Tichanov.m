%% Vectors
d1 = 110; % planar resulotion (x)
d2 = 102; % planar resulotion (y)
[Xsim,Ysim,Zsim] = meshgrid(0:1/(d1-1):1,0:1/(d2-1):1,0);
Xsim = reshape(Xsim,1,d); 
Ysim = reshape(Ysim,1,d);
Zsim = reshape(Zsim,1,d);
mesh = [Xsim;Ysim;Zsim];
AA = [];
%%
count = 1
for i = 1:5:d1
    for j = 1:5:d2
        for k = 1:10            
         %AA(:,end+1) = evalpotential(mesh,[1;i/d1;j/d2;k/100]);
        count = count +1;
        if(count==2000)
        [(i-1)/5,(j-1)/5,k]
        end
        end
    end
end
%%
x = AA*(floor(rand(4620,1)+.002)-floor(rand(4620,1)+.002));
x = zeros(4620,1); x(1000) = 1;x(2000) = -1;
x = AA*x;
%surf(reshape(x,d2,d1))
%%
%x = reshape(conv2(data(:,:,71),fspecial('gaussian',5,1),'same')',d,1);
b = ridge(x,AA,3);
%%
J = [22,10,21];
subplot(131)
surf(reshape(x,d2,d1))
subplot(132)
surf(reshape(AA*b,d2,d1))
subplot(133)
plot3(21,76,9,'.r');plot3(46,51,9,'.r');grid on;axis([1 d1 1 d2 1 10])
%%
I = find(b>.04);
[i,j,k] = ind2sub(J,I);
plot3(5*i+1,5*j+1,k,'.');grid on
hold on
I = find(b<-.04);
[i,j,k] = ind2sub(J,I)
plot3(5*i+1,5*j+1,k,'.r');grid on;axis([1 d1 1 d2 1 10])
