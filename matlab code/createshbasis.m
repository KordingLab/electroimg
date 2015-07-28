function Basis = createshbasis(x,z,y,degree)

% grid (x,z) with single y coordinate

Zcoord = reshape(repmat(z,length(x),1)',length(x)*length(z),1);
Xcoord = reshape(repmat(x,length(z),1),length(x)*length(z),1);
Ycoord = repmat(y,length(x)*length(z),1);

pts = [Xcoord, Ycoord, Zcoord];
dl=1; real_or_complex = 'real'; 

Basis = construct_SH_basis(degree, pts, dl, real_or_complex);

end