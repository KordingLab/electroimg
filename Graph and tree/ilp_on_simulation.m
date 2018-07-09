function [solutions, distance, X, Y] = ilp_on_simulation(swc_matrix, n_missing_node, n_noise)
n_miss = length(n_missing_node);
n_no = length(n_noise);
solutions = cell(n_miss, n_no);
X = cell(n_miss, n_no);
Y = cell(n_miss, n_no);
distance = zeros(n_miss, n_no);
order_node = histc(swc_matrix(:,7), unique(swc_matrix(:,7)));
n_non_branch = size(swc_matrix,1) - length(find(order_node>1));
if(n_non_branch > n_missing_node(end))
    for miss = 1:n_miss
        for noise = 1:n_no
            [miss, noise]
            swc = subsample(swc_matrix, n_missing_node(miss));
            [x, y, z, time, W, E] = tree_neuron(swc, n_noise(noise));
            x = x - x(1);
            y = y - y(1);
            z = z - z(1);
            
            % Running the slover
            my_params=[];
            my_params.split_cost=.1;%  Between 0 and 10q
            my_params.max_splits=-1;
            my_params.edge_offset=-.05;% Between q and -q
            
            my_params.my_rand_seed=0;
            my_params.por_split=1;
            my_params.epsilon=.0000001;
            
            F=[];
            F.x=x;
            F.y=y;
            F.z=z;
            F.time=time;
            F.bar_E=E;
            F.W=W;
            % F=load_data(my_input_file)
            G=pre_process(F,my_params);
            H=call_basic_ilp_solve(G);
            %save(my_output_file,'H');
            
            % The extrcted neuron
            par = H.Ebar.par;
            par(1) = 1;
            % ground truth
            %par = parent_index(E);
            % Making swc output
            solution_by_ilp = get_swc(par, x, y, z);
            solutions{miss, noise} = solution_by_ilp;
            X{miss, noise} = x;
            Y{miss, noise} = y;
            distance(miss, noise) = neuron_distance(swc_matrix, solution_by_ilp);
        end
    end
else
    'Error: Number of missing point should be lower than number of non-branching nodes of the neuron'
end