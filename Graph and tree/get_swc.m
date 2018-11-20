function swc = get_swc(parent, x,y,z)
if nargin<4
    z= zeros(1, length(x));
end
new_par = cc_par(parent);

nodes = find(new_par~=0);
n = length(nodes);
swc = zeros(n,7);
swc(1, 7) = -1;

if n>1
        swc(1,3) = x(nodes(1));
        swc(1,4) = y(nodes(1));
        swc(1,5) = z(nodes(1));    
    for i=2:n
        
        swc(i,7) = find(nodes == new_par(nodes(i)));
        swc(i,3) = x(nodes(i));
        swc(i,4) = y(nodes(i));
        swc(i,5) = z(nodes(i));
    end
else
end
swc(:, 1) = 1:n;