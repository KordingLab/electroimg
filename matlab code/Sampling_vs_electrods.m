clear
Neuron_positions = 1-2*rand(4,1);
Electrod_positions = 1-2*rand(3,5);
obs = evalpotential(Electrod_positions,Neuron_positions,.1);
fx = @(x)pointchargefn(x,obs,Electrod_positions);
options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','Display','off');
Sample = 10:2:150;
Sample = 1:20;
P = zeros(5,size(Sample,2));
% P is the best approximation of location of neurons based on method
% first raw is error and rests are charge + position
count = 1;
Count = 1;
for j =  1:size(Sample,2)
    for i = 1:Sample(j)
        Count = Count +1;
    end
end

for j =  1:size(Sample,2)
    for i = 1:Sample(j)
        Xstart = 1-2*randn(4,1);
        [X,FVAL] = fminunc(fx,Xstart,options);
        a(1,i) = sum((X-Neuron_positions).^2);
        a(2:5,i) = X;
        count/Count
        count = count +1;
    end
    [A,B] = min(a(1,:));
    P(:,j) = a(:,B);
end