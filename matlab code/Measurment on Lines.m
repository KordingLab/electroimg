close
neuron_data = randn(4,2);
for i = 1:30  
x1 = randn;
x2 = randn;
y1 = randn;
y2 = randn;
z1 = randn;
z2 = randn;
d = 50;
X = x1:(x2-x1)/d:x2;
Y = y1:(y2-y1)/d:y2;
Z = z1:(z2-z1)/d:z2;
f = evalpotential([X;Y;Z],neuron_data);
subplot(5,6,i)
plot(f)
end
