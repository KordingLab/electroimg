function X = fill_btw_pt(a,b)
X = [];
d = sum((a(1:3)-b(1:3)).^2).^.5;
for i = 1:1+floor(10*d)
r = rand;
x = (a(1:3)+r*(b(1:3)-a(1:3)));
X = [X;x];
end
