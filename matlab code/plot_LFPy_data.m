
close
K = 32;
for k = 20:402
   imagesc(reshape(a(71*40*K+[2:71*40+1],k),71,40))
   hold on;
   pause(.001)
   k
end
%%
for k = 2:402
[val,idd] = max(abs(a(2:end,k)))
[rowid(k),colid(k),zid(k)] = ind2sub([41,40,71],idd);
end
%%
sampid = randi(size(a,1)-1,5000);
a2 = a(2:end,:);
a3 = a2(sampid,:);


