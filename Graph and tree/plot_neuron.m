function plot_neuron(swc)
for i=2:length(swc)
    j = swc(i,7);
    plot([swc(i,3), swc(j,3)],[ swc(i,4), swc(j,4)]);
    hold on;
end
