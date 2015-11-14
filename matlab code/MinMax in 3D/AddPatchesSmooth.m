function D = AddPatchesSmooth(Frec)
D = zeros(60,100,125);
overlapsz = 25;
for i=1;
    for j=1:4;  
        for k=1:5;
            z = Frec{i,j,k};
            D((i-1)*overlapsz +1: min((i-1)*overlapsz +30,60),(j-1)*overlapsz +1 : +...
                min((j-1)*overlapsz +30,100),(k-1)*overlapsz +1 : min((k-1)*overlapsz +30,125)) ...
                = z+...
                D((i-1)*overlapsz +1: min((i-1)*overlapsz +30,60),(j-1)*overlapsz +1 : +...
                min((j-1)*overlapsz +30,100),(k-1)*overlapsz +1 : min((k-1)*overlapsz +30,125));
        end
    end
end