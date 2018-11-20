function plot_all_solutions(swc_solutions)
[n,m] = size(swc_solutions);
i = 1;
for n1 = 1:n
    for m1 = 1:m
        subplot(n,m,i) %n*(n1-1)+m1
        %plot_neuron(swc_solutions{n1, m1}.ground_truth, 'red');
         axis('off')
        hold on
        plot_neuron(swc_solutions{n1, m1}.solution);
        axis('off')
        i = i + 1;
    end
end