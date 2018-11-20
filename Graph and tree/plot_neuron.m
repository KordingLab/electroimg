function plot_neuron(swc, color)
% showing neuron
if nargin<2
    color = 'black';
end
n = size(swc,1);
if size(swc,1)>1
    lines_x_1 = [];
    lines_y_1 = [];
    lines_x_2 = [];
    lines_y_2 = [];
    for i=2:n
        node = i;
        par_node = swc(node,7);
        
        lines_x_1 = [lines_x_1, swc(node,3)];
        lines_x_2 = [lines_x_2, swc(par_node,3)];
        
        lines_y_1 = [lines_y_1, swc(node,4)];
        lines_y_2 = [lines_y_2, swc(par_node,4)];
        
        if ~ischar(color)
            c = jet(max(color));
            line([ swc(node,3);swc(par_node,3)], [swc(node,4);swc(par_node,4)],'Color',c(color(i),:))
        end
    end
    if ischar(color)
        line([lines_x_1;lines_x_2], [lines_y_1;lines_y_2],'Color',color)
    end
else
    error_msg = 'Nothing to show'
end

clc
