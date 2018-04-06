classdef SimElecRec
    properties
        first_split_amplitude = @(x) x;  % = @(x) x - .1;
        second_split_amplitude = @(x) x;  % = @(x) x - .05;
        % the change in amplitude value of the signal when it passes through one
        % split
        noise = 0;
        var_signals = 0;
        mesh = 128;
        n_detects = 1;
        theta_plus = [];
        theta_minus = [];
        theta_zero = [];
    end
    
    methods
        function [all_index_amp_active, all_location_amp_detections, ...
                index_location_amp_time] = simulation(obj, initialization, swc_matrix, T, dt)
            % Parameters:
            % -----------
            % initialization:
            % a matrix with 4 columns, the first 3 columns show the
            % 3d locations and the last column shows the amplitudes.
            
            % swc_matrix: swc matrix of neuron (size n*7)
            
            % T:
            % dt:
            
            % Returns:
            % --------
            % all_index_amp_active:
            % all_location_amp_detections:
            % time_location_amp:
            neuron_locations = swc_matrix(:, 3:5);
            parent_index = swc_matrix(:, 7);
            
            % Initialization
            active_index = obj.nearest_neuron_index_from_3d_loc(neuron_locations, initialization(:,1:3));
            index_amp_active = [active_index; transpose(initialization(:,4))];
            
            all_index_amp_active = cell(1, 1);
            all_location_amp_detections = cell(1, 1);
            
            all_index_amp_active{1} = index_amp_active;
            detect = obj.detection(index_amp_active, neuron_locations, obj.n_detects, obj.var_signals);
            all_location_amp_detections{1} = detect;
            index_location_amp_time = [detect, ones(size(detect,1),1)];
            n_step = 1;
            i = 2;
            
            %%%%%% this is the time evolving part of the function %%%%%
            
            % to ensure that the current time is always less than final time and
            % there is an active signal somewhere in each step, the while
            % loop is written.
            forward_matrix = obj.forward_matrix_of_one_neuron(parent_index);
            while(i < floor(T/dt) && length(index_amp_active)~=0)
                
                index_amp_active = obj.next_active_indcies(forward_matrix, ...
                    parent_index, index_amp_active, n_step);
                all_index_amp_active{1, end+1} = index_amp_active;
                detect = obj.detection(index_amp_active, neuron_locations, ...
                    obj.n_detects, obj.var_signals);
                all_location_amp_detections{1, end+1} = detect;
                n_detect = size(detect,1);
                
                index_location_amp_time(end+1:end+n_detect,:) = ...
                    [detect, i*ones(n_detect,1)];
                i = i + 1;
            end
            
        end
        
        function forward_matrix = forward_matrix_of_one_neuron(obj, parent_index)
            % Parameters:
            % -----------
            % parent_index
            % the index of the paretn in the swc format of the neuron.
            
            % Returns:
            % --------
            % forwad_matrix
            % forward_matrix has the shape of 2*n where n is the number of
            % the indecies of neuron. if the node is branching then the 2
            % arrays are its children otherwise they are the same.
            n = length(parent_index);
            forward_matrix = zeros(2, n);
            for i=2:n
                I = find(parent_index==i);
                if(length(I)>0)
                    forward_matrix(:,i) = I;
                end
            end
        end
        
        function index = nearest_neuron_index_from_3d_loc(obj, neuron_locations, given_locations)
            % Returing the indcies of closest point in neuron_locations
            % from the given location.
            
            % Parameters:
            % ----------
            % neuron_locations:
            %
            % given_locations:
            %
            % Returns:
            % --------
            % index:
            % the index of the closest nodes of the neuron.
            nl = size(neuron_locations,1);
            gl = size(given_locations,1);
            index = zeros(1, gl);
            for i=1:gl
                [~, ind] = min(sum((neuron_locations - ones(nl,1)*given_locations(i,:)).^2,2));
                index(i) = ind;
            end
        end
        function new_index_amp_active = next_active_indcies(obj, ...
                forward_matrix, parent_index, index_amp_active, n_step)
            for i=1:n_step
                index_amp_active = next(obj, forward_matrix, parent_index, index_amp_active);
            end
            new_index_amp_active = index_amp_active;
        end
        
        function next = next(obj, forward_matrix, parent_index, index_amp_active)
            %
            new_active_index = [];
            new_index_amp_active = [];
            if(size(index_amp_active,2)~=0)
                active_index = index_amp_active(1,:);
                if(active_index==1)
                    new_active_index = transpose(find(parent_index==1));
                    new_index_amp_active = index_amp_active(2,1)*ones(1,length(new_active_index));
                else
                    for i=1:length(active_index)
                        index = forward_matrix(:,active_index(i));
                        if(index(1)==0 && index(2)==0)
                        else
                            if(index(1)==index(2))
                                new_active_index(end+1) = index(1);
                                new_index_amp_active(end+1) = index_amp_active(2,i);
                            else
                                new_active_index(end+1) = index(1);
                                new_index_amp_active(end+1) = obj.first_split_amplitude(index_amp_active(2,i));
                                new_active_index(end+1) = index(2);
                                new_index_amp_active(end+1) = obj.second_split_amplitude(index_amp_active(2,i));
                            end
                        end
                    end
                end
            end
            next = [new_active_index; new_index_amp_active];
        end
        
        function detections = detection(obj, index_amp_active, ...
                neuron_locations, n_detects, var_signals)
            % Parameters:
            % index_amp_active: a matrix of the size ?*2 that contains the
            % index of the active index at the first column and the
            % amplitudes of each index in the second column.
            %
            % neuron_locations: ?*3 matrix of x, y and z of the locations
            % of the neuron's nodes.
            % Return:
            % detections: the 3d location of the detections by the active
            % indexs of the neuron. For each signal in the active nides,
            % the detections are coming from a
            % gussian distribution with the mean of the active index and
            % the given variance.
            detections = [];
            if(size(index_amp_active,2)~=0)
                loc_actives = neuron_locations(index_amp_active(1,:), :);
                n_index = length(index_amp_active(1,:));
                
                for i=1:n_index
                    detections(1+(i-1)*n_detects:i*n_detects,1) = ...
                        index_amp_active(1,i)*ones(n_detects);
                    detections(1+(i-1)*n_detects:i*n_detects,2:4) = ...
                        ones(n_detects,1)*loc_actives(i,:) + var_signals*rand(n_detects,3);
                    detections(1+(i-1)*n_detects:i*n_detects,5) = ones(n_detects,1)*index_amp_active(2, i);
                end
            end
        end
        
        function subtracks = subtracks(obj, index_location_amp_time, k, threshold)
            % k is the number of steps for the subtracks
            % output is a matrix of suntrcks * (k+4)
            % first column = being soma
            % Second column = being branch
            time_location_amp = index_location_amp_time(:,2:end-1);
            time_location_amp = [index_location_amp_time(:, end), time_location_amp];
            all_indecies_t = obj.time_indecies(time_location_amp);
            detections_on_subtrack = obj.all_appropriate_indecies(k,all_indecies_t);
            n_subtrack = size(detections_on_subtrack,1);
            subtracks = ones(n_subtrack, k+4);
            length_subtracks = zeros(n_subtrack,1);
            for i=1:k-1
                dis = time_location_amp(detections_on_subtrack(:,i),2:4)-...
                    time_location_amp(detections_on_subtrack(:,i+1),2:4);
                length_subtracks = length_subtracks + sqrt(sum(dis.^2,2));
            end
            time_subtracks = time_location_amp(detections_on_subtrack(:,k),1);
            possible_branch = zeros(n_subtrack,1);
            possible_terminal = zeros(n_subtrack,1);
            % distance = squareform(pdist(time_location_amp(:,2:4)));
            distance = obj.square_pdist_accessories(time_location_amp(:,2:4));
            for t=k:max(time_subtracks)-1
                next_frame = all_indecies_t{t+1};
                subtrack_indecis = find(time_subtracks==t);
                end_detection = detections_on_subtrack(subtrack_indecis,k);
                threshold_dist = sum(distance(end_detection, next_frame)<threshold,2);
                possible_branch(subtrack_indecis) = max(sign(threshold_dist-1),0);
                possible_terminal(subtrack_indecis) =  1 - sign(threshold_dist);
            end
            %subtracks(find(detections_on_subtrack(:,1)==1),1) = 1;
            
            subtracks(2:end,1) = 0;
            subtracks(:,2) = possible_branch;
            subtracks(:,3) = possible_terminal;
            subtracks(:,4) = length_subtracks;
            subtracks(:,5:k+4) = detections_on_subtrack(:,1:k);
        end
        
        function product = product(obj, A,B)
            product = [];
            for i=1:length(B)
                product = [product;[A,B(i)*ones(size(A,1),1)]];
            end
            
        end
        
        function products = products(obj, A)
            % A is a cell containing horizental matries
            % Return: the product of all matries
            products = obj.product(A{1},A{2});
            for i=3:length(A)
                products = obj.product(products,A{i});
            end
        end
        
        
        
        function indecies = all_appropriate_indecies(obj, k, times)
            indecies = obj.products(times(1:k));
            for i=2:length(times)-k+1
                indecies = [indecies; obj.products(times(i:k+i-1))];
            end
        end
        
        function time_ind = time_indecies(obj, time_location_amp)
            time_ind = cell(0);
            first_time = min(time_location_amp(:,1));
            last_time = max(time_location_amp(:,1));
            for i = first_time:last_time
                time_ind{i} = find(time_location_amp(:,1)==i);
            end
        end
        
        function dist = square_pdist_accessories(obj, matrix)
            n = size(matrix, 1);
            dist = zeros(n,n);
            for i=1:n
                dist(i, :) = sqrt(sum((matrix - ones(n,1)*matrix(i,:)).^2,2));
            end
        end
        
        function synapses(neuron1, neuron2, location)
            % input:
            % neruon1, neuron2: the index of first and second neuron
            % location: 3d location of a place in the space that two neurons
            % are going to be connected.
        end
        
        function records = recording(obj, x_rec_vertex, y_rec_vertex, mesh, all_location_amp_detections)
            t = length(all_location_amp_detections);
            x1 = x_rec_vertex(1);
            x2 = x_rec_vertex(2);
            y1 = y_rec_vertex(1);
            y2 = y_rec_vertex(2);
            [x, y] = meshgrid(x1:(x2-x1)/(mesh-1):x2, y1:(y2-y1)/(mesh-1):y2);
            x = reshape(x, [1, mesh^2]);
            y = reshape(y, [1, mesh^2]);
            records = zeros(t,mesh,mesh);
            for i=1:t
                rec = zeros(1, mesh^2);
                loc = all_location_amp_detections{i};
                
                for j=1:size(loc,1)
                    rec = rec + loc(j,4) * (abs(x-loc(j,1)).^1.8 + ...
                        abs(y - loc(j,2)).^1.8 + ...
                        abs(loc(j,3))^1.8).^-.5 + obj.noise* randn(1, mesh^2);
                    records(i,:,:) = flipud(reshape(rec, [mesh, mesh]));
                end
                
            end
            
        end
        
        function video_frames = video(obj, swc_matrix, all_location_amp_detections)
            % Returns:
            % --------
            % video_frames: 3d matrix
            %   a matrix of size n*128*128 where n is the number of frames.
            x_rec_vertex = [min(swc_matrix(:,3))-10,max(swc_matrix(:,3))+10];
            y_rec_vertex = [min(swc_matrix(:,4))-10,max(swc_matrix(:,4))+10];
            video_frames = obj.recording(x_rec_vertex, y_rec_vertex, obj.mesh, ...
                all_location_amp_detections(1:end-1));
        end
        function show_sim(obj, records)
            for i = 1:size(records,1)
                imagesc(squeeze(records(i,:,:)));
                pause(.05);
                caxis([0,200])
            end
            
        end
        function save_tif(obj, sim, path)
            M = max(max(max(sim)));
            m = min(min(min(sim)));
            for i=1:size(sim,1)
                path_name = strcat(strcat(path,'/t='), strcat(int2str(i), '.tif'));
                imwrite(squeeze((sim(i,:,:)-m)/(M-m)), path_name);
            end
        end
        function save_video(obj, sim, path)
            outputVideo = VideoWriter(path);
            outputVideo.FrameRate = 10;
            open(outputVideo)
            
            for i = 1:size(sim,1)
                img = squeeze(sim(i,:,:));
                m = min(min(img));
                ma = max(max(img));
                img = (img-m)/(ma-m);
                writeVideo(outputVideo,img)
            end
            close(outputVideo)
        end
        function select_suntracks(obj, k, time_location_amp)
            first_time = min(time_location_amp(:,1));
            last_time = max(time_location_amp(:,1));
            for i = first_time-1:last_time
                find(time_location_amp(:,1))
            end
        end
        function get_reconstruct(obj, H, n_node, path, save_path)
            lineage = full(H.lineage);
            lineage_in_index = find(lineage);
            n_node = length(lineage_in_index);
            time_location_amp = load(path);
            time_location_amp = time_location_amp.time_location_amp;
            swc = zeros(n_node,7);
            index_in_lineage = zeros(n_node);
            parent_index = -ones(n_node,1);
            for i = 2:n_node
                swc(i,1) = i;
                swc(i,7) = find(lineage_in_index==lineage(lineage_in_index(i)));
                swc(i, 3:5) = time_location_amp(lineage(lineage_in_index(i)),2:4);
            end
            save(save_path,'swc')
        end
        function grand_t = grand_truth(obj, D, P, C, S, k)
            grand_t = [];
            for i=1:max(C)
                par = i;
                grand_parent = zeros(1,k);
                for i=1:k
                    if par > 0
                        grand_parent(k-i+1) = par;
                        par = P(par);
                    end
                end
                index_in_C = zeros(1,k);
                for i=1:k
                    if grand_parent(i) > 0
                        index_in_C(i) = find(C == grand_parent(i));
                    end
                end
                
                a = find(sum(abs(S- ones(size(S, 1), 1) * index_in_C), 2)==0);
                if ~isempty(a)
                    grand_t(end+1) = a;
                end
            end
        end
        function [theta_plus, theta_minus, theta_zero] = theta_cost(obj, S)
            theta_plus = ones(1, size(S,1));
            theta_minus = ones(1, size(S,1));
            theta_zero = ones(1, size(S,1));
        end
        function [s_plus, s_minus, s_zero] = s_function(obj, p, S)
            s_plus = [];
            s_minus = [];
            s_zero = [];
            for i=p
                
                a = find(sum(abs(S(p, 1:end-1) - ones(length(p), 1) * S(i, 2:end)), 2)==0);
                b = find(sum(abs(S(p, 2:end) - ones(length(p), 1) * S(i, 1:end-1)), 2)==0);
                if isempty(a)
                    s_plus(end+1) = i;
                end
                if isempty(b)
                    s_minus(end+1) = i;
                end
                if ~isempty(a) && ~isempty(b)
                    s_zero(end+1) = i;
                end
            end
        end
        function [X, X_hat] = X_function(obj, S, D, p)
            
            detection_in = [];
            for i=1:k
                detection_in(end+1:end+length(p)) = S(p,i);
            end
            detection_in = unique(detection_in);
            X = zeros(1, size(D, 1));
            X_hat = zeros(1, size(D, 1));
            X(detection_in) = 1;
            X_hat(unique(S(p, k))) = 1;
        end
    end
end
