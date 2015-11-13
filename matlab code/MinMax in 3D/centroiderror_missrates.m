function [dvec,TP,FP,M,Matches] = centroiderror_missrates(C0,C1,thresh)

D = pdist2(C0',C1');
[vals,sortid] = sort(min(D),'ascend'); 
L = length(find(vals<=thresh));
D2 = pdist2(C0',C1(:,sortid)');

Matches = zeros(2,L);
dvec = zeros(L,1);
for i=1:L    
    idcol = i;
    [valtmp,idrow] = min(D2(:,i));
    if valtmp<=thresh
        Matches(:,i) = [idrow;idcol];
        dvec(i) = valtmp;
    end
    D2(idrow,:)=100;
    D2(:,idcol)=100;
end

idd = dvec>thresh;
Matches(:,idd)=[];

numcorrect = size(Matches,2);
numgt = size(C0,2);
numrecov = size(C1,2);

TP = numcorrect/numrecov;
FP = 1 - TP;
M = (numgt - numcorrect)/numgt;

end % end main function