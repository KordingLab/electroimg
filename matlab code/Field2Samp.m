function samp=Field2Samp(p,sampnum)
psz=size(p);
pvect=p(:)';
indsamp= gendist(pvect, sampnum,1);
%[I1, I2, I3]=ind2sub(psz,indsamp);samp= [I1, I2, I3];
[I1, I2]=ind2sub(psz,indsamp);samp= [I1, I2];


return;