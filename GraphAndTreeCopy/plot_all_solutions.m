function plot_all_solutions(swc_solutions)
[n,m] = size(swc_solutions);
for n1 = 1:n
    for m1 = 1:m
        swc = swc_solutions{n1, m1};
        for i=2:size(swc,1)
            j = swc(i,7);
            
            subplot(n,m,n*(n1-1)+m1)
            plot([swc(i,3), swc(j,3)],[ swc(i,4), swc(j,4)]);
            hold on;
        end
    end
end