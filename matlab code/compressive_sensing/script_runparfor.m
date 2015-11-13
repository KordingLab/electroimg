load('NeuroData-11-11(2).mat')

parpool(8)
for ii=1:4
for i=1:3; 
    for j=1:6; 
        parfor k=1:7; 
            F0 = newData((i-1)*15 +1 : min((i-1)*15 +30,60),...
                (i-1)*15 +1 : min((i-1)*15 +30,100),...
                (i-1)*15 +1 : min((i-1)*15 +30,125),20);
            
            [Frec{i,j,k},whichsamp{i,j,k}] = interpolatefield2(F0,0.2*ii,1e-6);
        end
        save(['Results-11-12-sampsz-',num2str(0.2*ii,1)],'Frec','whichsamp','F0')
    end
end
end
            
            
            
            