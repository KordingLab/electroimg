function Errs = computeLFerr(F0,Frec,whichsamp,xrange,yrange,zrange,trueloc)

if nargin<7
    trueloc = [0,0,0];
end

stacksz = size(F0);
%neuron_ctr = [find(xrange==trueloc(1)),find(yrange==trueloc(2)),find(zrange==trueloc(3))];

LFsamples = F0(whichsamp);

[~,id] = max(abs(LFsamples));
[maxsamp(1),maxsamp(2),maxsamp(3)] = ind2sub(stacksz,whichsamp(id));
loc_maxsamp = [xrange(maxsamp(1)),yrange(maxsamp(2)),zrange(maxsamp(3))];

[~,idrec] = max(abs(Frec(:)));
[maxrec(1),maxrec(2),maxrec(3)] = ind2sub(stacksz,idrec);
loc_maxrec = [xrange(maxrec(1)),yrange(maxrec(2)),zrange(maxrec(3))];

Errs.ErrMaxRec = norm(trueloc-loc_maxrec);
Errs.ErrMaxSamp = norm(trueloc-loc_maxsamp);
Errs.ErrField = norm(Frec(:)-F0(:))./norm(F0(:));

end
