function pitchsz = meanpitchsz(whichsamp,stacksz,sampres)

[xx,yy,zz] = ind2sub(stacksz,whichsamp);
ElectrodePos = [xx, yy, zz].*sampres;

Dmat = pdist2(ElectrodePos,ElectrodePos)+eye(length(whichsamp))*100;

tmp = min(Dmat)*sampres;
tmp(find(tmp==0))=[];

pitchsz = mean(tmp);


end




