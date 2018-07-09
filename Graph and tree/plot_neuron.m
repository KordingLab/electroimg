function plot_neuron(swc)
if size(swc,1)>1
    for i=2:size(swc,1)
        j = swc(i,7);
        plot([swc(i,3), swc(j,3)],[ swc(i,4), swc(j,4)]);
        hold on;
    end
else
    error_msg = 'Nothing to show'
end
