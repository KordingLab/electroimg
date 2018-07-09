function plot_neuron_compare(swc_matrix_primary, swc_solution, x, y)

for i=2:size(swc_matrix_primary,1)
    j = swc_matrix_primary(i,7);
    subplot(3,1,1)
    plot([swc_matrix_primary(i,3), swc_matrix_primary(j,3)],[ swc_matrix_primary(i,4), swc_matrix_primary(j,4)]);
    hold on;
end




for i=2:size(swc_solution,1)
    j = swc_solution(i,7);
    subplot(3,1,2)
    plot([swc_solution(i,3), swc_solution(j,3)],[ swc_solution(i,4), swc_solution(j,4)]);
    hold on;
end


for i=2:size(swc_matrix_primary,1)
    j = swc_matrix_primary(i,7);
    subplot(3,1,3)
    plot([swc_matrix_primary(i,3), swc_matrix_primary(j,3)],[ swc_matrix_primary(i,4), swc_matrix_primary(j,4)]);
    hold on;
end

for i=2:size(swc_solution,1)
    j = swc_solution(i,7);
    subplot(3,1,3)
    plot([swc_solution(i,3), swc_solution(j,3)],[ swc_solution(i,4), swc_solution(j,4)],'r');
    hold on;
end
subplot(3,1,3)
scatter(x,y)
