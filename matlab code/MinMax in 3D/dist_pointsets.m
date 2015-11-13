function [dvec,TP,FP,M,Matches] = dist_pointsets(C0,C1,thresh)

D = pdist2(C0',C1');
[vals,sortid] = sort(min(D),'ascend'); 


end % end main function