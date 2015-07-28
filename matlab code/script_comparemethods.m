%script_comparemethods

load TestSet; 
N = size(X2,2);

kmax = 10;
errnm = 0.1;

% run clustered OMP solver
Errs = zeros(41,N,3);
EstErr = zeros(N,3);

for i=1:N
    y = X2(:,i)./norm(X2(:,i));
    
    % clustered OMP
    [~,~,~,Errs(:,i,1),~,Depth] = ...
        partial_clustOMP_estimates(y,errnm,kmax,0); 
    [~,minid] = min(Errs(:,i,1));
    EstErr(i,1) = abs(abs(truedepth(i)*(10^-6)) - abs(Depth(minid)))*(10^6);
   
    % OMP
    [~,~,~,Errs(:,i,2)] = partial_OMPestimates(y,errnm,kmax,0);
    [~,minid] = min(Errs(:,i,2));
    EstErr(i,2) = abs(abs(truedepth(i)*(10^-6)) - abs(Depth(minid)))*(10^6);
    
    % Least Squares
    [~,~,Errs(:,i,3)] = partial_LSestimates(y,0);
    [~,minid] = min(Errs(:,i,3));
    EstErr(i,3) = abs(abs(truedepth(i)*(10^-6)) - abs(Depth(minid)))*(10^6);
    
    display(['cOMP Err = ', num2str(EstErr(i,1),1), ...
        ', OMP Err = ', num2str(EstErr(i,2),1), ...
        ', LS Err = ', num2str(EstErr(i,3),1)])
    
    display(['Num of Iterations Left = ', num2str(N-i)])
end