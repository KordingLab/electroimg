X0 = [1; 0.4; -0.1; .6];
X0 = rand(4,1);
num_iter = 150;
grid_pos = 1-2*rand(3,5);
yobs = evalpotential(grid_pos,X0);
for i=1:num_iter
Xstart = 1-2*randn(4,1);
fx = @(x)pointchargefn(x,yobs,grid_pos);
options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
[X,FVAL] = fminunc(fx,Xstart,options);
a(1,i) = sum((X-Xstart).^2);
a(2:5,i) = X;
i/num_iter
end
[A,B] = min(a(1,:));
a(2:5,B)
%%
scatter3(grid_pos(1,:),grid_pos(2,:),grid_pos(3,:))
hold on
scatter3(0.4,-0.1,.6)