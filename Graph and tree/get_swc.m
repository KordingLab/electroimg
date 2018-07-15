function swc = get_swc(parent, x,y,z)
nodes = find(parent~=0);
n = length(nodes);
swc = zeros(n,7);
swc(1, 7) = -1;
if n>1
    for i=2:n
        swc(i,7) = find(nodes == parent(nodes(i)));
        swc(i,3) = x(nodes(i));
        swc(i,4) = y(nodes(i));
        swc(i,5) = z(nodes(i));
    end
else
end
swc(:, 1) = 1:n;