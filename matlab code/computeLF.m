function Y = computeLF(xout,vol_coord)

num = size(xout,1);
N = size(vol_coord,1);

dims = [length(unique(vol_coord(:,1))), ...
    length(unique(vol_coord(:,2))), length(unique(vol_coord(:,3)))];

Y = zeros(dims);

for i=1:num
    [~,id] = min(sum((repmat(xout(i,1:3),N,1) - vol_coord).^2,2));
        Y(id(j),id(j),id(j)) = cout(i);
    end
end

end