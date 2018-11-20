function precentage_noise = find_best_missing(swc_matrix, threshold_dis_connect, split_cost,...
    initial_guess, hass_dis, steps)

time_step = size(swc_matrix,1);
n_missing_node = zeros(1,1);
precentage_noise = initial_guess;

consecuatve_frames = 1;
edge_coff = 1;
max_kids = 2;
max_splits = -1;
edge_offset = -.1;
cost= 'distance';
stick_binary_tree = 1;

flag = 1;
while flag
    n_noise = [floor(time_step*precentage_noise)];
    sim = ilp_on_simulation(swc_matrix, ...
        n_missing_node, stick_binary_tree, n_noise, split_cost, edge_offset,...
        max_kids, max_splits, cost, consecuatve_frames, threshold_dis_connect, edge_coff,0);
    
    er = [];
    for j=1:size(sim,1)
        er(end+1)= sim{j,1}.hassdurf_distance;
    end
    mean(er)
    if abs(mean(er)-hass_dis)<.01
        flag = 0;
    else
        if mean(er)>hass_dis
            precentage_noise = precentage_noise - steps;
        else
            precentage_noise = precentage_noise + steps;
        end
        
    end
end