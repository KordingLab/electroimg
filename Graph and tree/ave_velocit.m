function v = ave_velocit(swc_matrix)
par = swc_matrix(:,7);
par(1)=1;
dis = sqrt(sum((swc_matrix(par, 3:4)-swc_matrix(:, 3:4)).^2,2));
v = mean(dis);