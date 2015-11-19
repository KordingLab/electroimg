load('NeuroData-11-11(2).mat')

overlapsz = 25;

for ii=1
for i=2; 
    for j=4; 
        parfor k=1:5; 
            F0 = newData((i-1)*overlapsz +1 : min((i-1)*overlapsz +30,60),...
                (j-1)*overlapsz +1 : min((j-1)*overlapsz +30,100),...
                (k-1)*overlapsz +1 : min((k-1)*overlapsz +30,125),20);
            
            [Frec{i,j,k},whichsamp{i,j,k}] = interpolatefield2(F0,0.1*ii,1e-6);
        end
        save(['Results-11-13-eld615-sampsz-0-pt-',num2str(0.02*ii*10,2)],'Frec','whichsamp')
    end
end
end
            
            
            
            