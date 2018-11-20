function solutions = ilp_on_simulation(swc_matrix, n_missing_node, ...
    stick_binary_tree, n_noise, split_cost, edge_offset, max_kids, ...
    max_splits, cost, consecuatve_frames, threshold_dis_connect, edge_coff, simple_save)
n_miss = length(n_missing_node);
n_no = length(n_noise);
solutions = cell(n_miss, n_no);

distance = zeros(n_miss, n_no);
order_node = histc(swc_matrix(:,7), unique(swc_matrix(:,7)));
n_non_branch = size(swc_matrix,1) - length(find(order_node>1));

if(n_non_branch > n_missing_node(end))
    for miss = 1:n_miss
        for noise = 1:n_no
            [miss, noise]
            if sum(size(consecuatve_frames))>2
                consecuatve_frame = consecuatve_frames(miss,noise);
            else
                consecuatve_frame = consecuatve_frames;
            end
            [x, y,  time, W, E, Epar] = tree_neuron(swc_matrix, cost,...
                threshold_dis_connect, edge_coff, consecuatve_frame, n_noise(noise), n_missing_node(miss),...
                stick_binary_tree);
            %             x = x - x(1);
            %             y = y - y(1);
            %             z = z - z(1);
            
            % Running the slover
            my_params=[];
            my_params.split_cost=split_cost;%  Between 0 and 10q
            my_params.max_splits=max_splits;
            my_params.edge_offset=edge_offset;%-.05;% Between q and -q
            my_params.max_kids=max_kids;
            
            my_params.my_rand_seed=n_no*miss+noise;
            my_params.por_split=1;
            my_params.epsilon=.0000001;
            
            F=[];
            F.x=x;
            F.y=y;
            %F.z=z;
            F.time=time;
            F.bar_E=zeros(size(E));
            F.W=-W;
            
            %imshow(full(W))
            %sum(sum(full(W)))
            G=pre_process(F,my_params);
            H=call_basic_ilp_solve(G);
            
            % The extrcted neuron
            par = H.Ebar.par;
            par(1) = 1;
            par = cc_par(par);
            % Making swc output
            %solution_by_ilp = get_swc(par, x, y, z);
            solution_by_ilp = get_swc(par, x, y);
            
            if simple_save %only onr output
                sim_details = [];
                sim_details.hassdurf_distance = neuron_distance(swc_matrix, solution_by_ilp);
                sim_details.max_time = max(time);
                non_zero_epar = find(Epar~=0);
                a = par-Epar;
                sim_details.ratio_similar_edges = size(find(a(non_zero_epar)==0),1)/length(non_zero_epar);
            else
                % output of simulation
                sim_details = [];
                sim_details.solution = solution_by_ilp;
                sim_details.H = H;
                sim_details.ground_truth = swc_matrix;
                sim_details.par = par;
                sim_details.x = x;
                sim_details.y = y;
                %sim_details.z = z;
                sim_details.time = time;
                sim_details.n_noise = n_noise(noise);
                sim_details.n_missing_node = n_missing_node(miss);
                sim_details.stick_binary_tree = stick_binary_tree;
                
                % cost function
                sim_details.threshold_dis_connect = threshold_dis_connect;
                sim_details.cost = cost;
                sim_details.edge_offset = edge_offset;
                sim_details.max_kids = max_kids;
                sim_details.split_cost = split_cost;
                sim_details.consecuatve_frames = consecuatve_frame;
                sim_details.edge_coff = edge_coff;
                
                % distance with ground truth
                sim_details.hassdurf_distance = neuron_distance(swc_matrix, solution_by_ilp);
                non_zero_epar = find(Epar~=0);
                a = par-Epar;
                sim_details.ratio_similar_edges = size(find(a(non_zero_epar)==0),1)/length(non_zero_epar);
                a = number_of_branches(Epar);
                b = number_of_branches(solution_by_ilp(:,7));
                sim_details.n_branches = [a, b, (a/b) - 1];
                a = size(swc_matrix,1);
                b = size(solution_by_ilp,1);
                sim_details.n_edges = [a, b, (a/b) - 1];
                %             sim_details.distance = max([sim_details.hassdurf_distance, ...
                %             abs(sim_details.n_edges(3)), abs(sim_details.n_branches(3)), ...
                %             abs(sim_details.ratio_similar_edges)]);
                
                sim_details.distance = max([sim_details.hassdurf_distance, ...
                    abs(sim_details.ratio_similar_edges)]);
                
                sim_details.ave_gt_detections_per_frame = size(swc_matrix,1)/max(time);
                sim_details.ave_detections_per_frame = length(x)/max(time);
                sim_details.ave_velocity_gt = ave_velocit(swc_matrix);
                sim_details.max_time = max(time);
                
            end
            
            
            solutions{miss, noise} = sim_details;
        end
    end
else
    'Error: Number of missing point should be lower than number of non-branching nodes of the neuron'
end