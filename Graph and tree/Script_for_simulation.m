%% making .mat file from a .txt file containing swc
clc
clear
nmo_ind = '05463';
nmo_ind = '72871';
%nmo_ind = '61718';
name_file = strcat('xml_matrix_NMO_',nmo_ind);

neuron_data = textread(strcat('/Volumes/Arch/Downloads/',name_file));
length_ind = 9;
swc_matrix = neuron_data(find(neuron_data(:,8)==length_ind),1:7);
swc_matrix(1, 7) = -1;
swc_matrix_primary = swc_matrix;

%%
clc
split_cost = .01;
threshold_dis_connect = (length_ind+1)*.01;
consecuatve_frames = 1;
edge_coff = 1;

max_kids = 2;
max_splits = -1;
edge_offset = -.1;
cost= 'distance';
stick_binary_tree = 1;

time_step = size(swc_matrix_primary,1);
n_missing_node = [0];
%n_missing_node = zeros(1,2);
%n_missing_node = [0];
n_noise = [0:floor(time_step*1):time_step*4];
n_noise = [time_step*10];
%n_noise = [floor(time_step*1.5)];
%n_noise = zeros(1,1);

[x, y,  time, W, E, Epar] = tree_neuron(swc_matrix_primary, cost,...
    threshold_dis_connect, edge_coff, consecuatve_frames, 0, 0,...
    stick_binary_tree);
time_step = max(time);
n_noise = [time_step*100];

sim = ilp_on_simulation(swc_matrix_primary, ...
    n_missing_node, stick_binary_tree, n_noise, split_cost, edge_offset,...
    max_kids, max_splits, cost, consecuatve_frames, threshold_dis_connect, edge_coff,0);
%sim11 = sim{1,1};
%% Plot simulations
close all

hold on
plot_neuron(swc_matrix_primary, 'r')
plot_all_solutions(sim(1:end,1:end))
%%
close all
mean_er = [];
std_er = [];
interval = 1:size(sim,2);
for i=interval
    er_j = [];
    for j=1:size(sim,1)
        er_j(end+1)= sim{j,i}.hassdurf_distance;
        %er_j(end+1)= sim{j,i}.ratio_similar_edges;
        %er_j(end+1)= sim{j,i}.distance;
    end
    mean_er(end+1) = mean(er_j);
    std_er(end+1) = std(er_j);
end
mean_er
plot(mean_er)
%%
close all
plot(mean_er)
fill([interval,fliplr(interval)],[mean_er-std_er,fliplr(mean_er+std_er)],'b');

%axis('off')

%%
plot_neuron(swc_matrix)
axis('off')
%% show & save video
close all;
sim11 = sim{end,end};
data = zeros(1,1);
frames_input = 1:max(sim11.time);
H_input = sim11.H;
x_input = sim11.x;
y_input = sim11.y;
t_input = transpose(sim11.time);
ground_truth = sim11.ground_truth;
plot_detections = 1;
plot_neuron_b = 1;
plot_recording = 1;

pause_step = .15;
save_video = 0;
name = 'just_detections_sim';
F = plot_moving_detections(data, frames_input, H_input, x_input, y_input, ...
    t_input, plot_detections, plot_neuron_b, plot_recording, pause_step,...
    save_video, name, ground_truth);
%% Save

writerObj = VideoWriter('detections.avi');
writerObj.FrameRate = 3;
open(writerObj);
for u=frames
    u
    frame = F{u};
    %for v=1:length(images)
    writeVideo(writerObj, frame)
    %end
end
close(writerObj);

%%
par = swc_matrix_primary(:,7);
par(1)=1;
dis = sqrt(sum((swc_matrix(par, 3:4)-swc_matrix(:, 3:4)).^2,2));
plot(dis)

%% Hausdorff distance between neuron and the subsampled neurons
% max_node_to_remove = 300;
% ite = 5;
% dis = zeros(ite, 30);
% count = 1;
% for i =0:10:max_node_to_remove
%     count
%     for j =1:ite
%         swc_matrix = subsample(swc_matrix_primary, i);
%         dis(j,count) = neuron_distance(swc_matrix, swc_matrix_primary);
%
%     end
%     count = count +1;
% end
% plot(sum(dis,1))

clc
%clear
nmo_ind = '05463';
%nmo_ind = '72871';
nmo_ind = '61718';
name_file = strcat('xml_matrix_NMO_',nmo_ind);

neuron_data = textread(strcat('/Volumes/Arch/Downloads/',name_file));
length_ind = 4;
swc_matrix = neuron_data(find(neuron_data(:,8)==length_ind),1:7);
swc_matrix(1, 7) = -1;
swc_matrix_primary = swc_matrix;


%%
close all
mean_er = [];
std_er = [];
interval = 1:size(sim,1);
for i=interval
    er_j = [];
    for j=1:size(sim,2)
        er_j(end+1)= sim{i,j}.hassdurf_distance;
        %er_j(end+1)= sim{i,j}.ratio_similar_edges;
        %er_j(end+1)= sim{j,i}.distance;
    end
    mean_er(end+1) = mean(er_j);
    std_er(end+1) = std(er_j);
end
mean_er
plot(mean_er)
%%
close all
subplot(1,3,1)
fill([interval,fliplr(interval)],[mean_er-std_er,fliplr(mean_er+std_er)],'b');