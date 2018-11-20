%%
clear
%load('srep31332-s2');
load('/Volumes/Arch/Google Drive/Projects/Electrical Imaging/Data/Nature 2016 paper/srep31332-s4.mat');
%%
% inject =[x_initial_detection, y_initial_detection, amplitude_initial_detection,...
%    x_remove_detection_around, y_remove_detection_around, time_after_remove_detection_around]
% border = [x_min, x_max, y_min, y_max];
%% Neuron (movie 4: footprint)

frames = 417:437;
inject = [220, 92, -17, ...
    -20, -20, 5, 22];
border = [1,488,1,421];
amp_thrsh = 5;
conv_window = 10;
consecuatve_frames=2;
edge_coff=1;
threshold_dis_connect=35; % 1 pixel = 4 um
threshold_amp = 8;
split_cost = 10;
cutoff=5;

%% Neuron 1 (footprint)

frames = 25:64;
inject = [220, 92, -17, ...
    -20, -20, 5, 22];
border = [1,238,120,421];
amp_thrsh = 5;
conv_window = 10;
consecuatve_frames=2;
edge_coff=1;
threshold_dis_connect=35; % 1 pixel = 4 um
threshold_amp = 8;
split_cost = 10;
cutoff=5;

%% Neuron 2 (footprint)

frames = 146:184;
inject = [220, 120, 5, ...
    -20, -20, 5, 22];

border = [1,300,50,370];
amp_thrsh = 5;
conv_window = 10;
consecuatve_frames=1;
edge_coff=1;
threshold_dis_connect=32; % 1 pixel = 4 um
threshold_amp = 8;
split_cost = 10;
cutoff=14;

%% neuron 1
% frames = 5:73;
% inject = [195, 300, 70, 8];
% amp_thrsh = 30;
% conv_window = 5;
% consecuatve_frames=1;
% edge_coff=1;
% threshold_dis_connect=35;
% threshold_amp = 40;
% split_cost = 6;
% cutoff=40;

%inject =[x_initial_detection, y_initial_detection, amplitude_initial_detection,...
%    x_remove_detection_around, y_remove_detection_around, time_after_remove_detection_around, radius]

%amp_detect(find(t_detect==5))
frames = 5:65;
inject = [203, 180, -2.1, ...
    197, 301, 5, 22];
amp_thrsh = 2.5;
conv_window = 3;
consecuatve_frames=1;
edge_coff=1;
threshold_dis_connect=38; % 1 pixel = 4 um
threshold_amp = 5;
split_cost = 25;
cutoff=40;
%% neuron 2
frames = 134:195;
inject = [160, 409, 30, 136];
amp_thrsh = 30;
conv_window = 5;
consecuatve_frames=1;
edge_coff=1;
threshold_dis_connect=50;
threshold_amp = 40;
split_cost = 5;
%% neuron 3
frames = 267:320;
inject = [390, 450, -60, 270];
amp_thrsh = 30;
conv_window = 5;
consecuatve_frames=1;
edge_coff=1;
threshold_dis_connect=40;
threshold_amp = 40;
split_cost = 1;
%% neuron 4
frames = 388:426;
inject = [247, 360, -30, 392];
amp_thrsh = 30;
conv_window = 5;
consecuatve_frames=1;
edge_coff=1;
threshold_dis_connect=30;
threshold_amp = 30;
split_cost = 1;
%% Extracting detections
clc
[x_detect, y_detect, amp_detect, t_detect] = find_all_detections(D2,...
    frames, amp_thrsh, conv_window, cutoff, inject(4), inject(5), inject(6), inject(7));

x_detect = [inject(1); x_detect];
y_detect = [inject(2); y_detect];
amp_detect = [inject(3); amp_detect];
t_detect = [min(t_detect)-1; t_detect];

%% cost function
clc

cost = 'distance';
W = cost_f(x_detect,y_detect, amp_detect, transpose(t_detect),...
    consecuatve_frames, edge_coff, threshold_dis_connect, threshold_amp, cost);
%imshow(full(W))
%find(sum(W,2)==0)
% ilp
max_kids = 2;
max_splits = -1;
edge_offset = 0;
H = ilp_for_detctions(x_detect, y_detect, t_detect, -W,...
    split_cost, edge_offset, max_kids, max_splits);
par = H.Ebar.par;
par(1) = 1;
solution_by_ilp = get_swc(par, x_detect, y_detect, ones(length(x_detect),1));
%solution_by_ilp(1,3:5)=solution_by_ilp(2,3:5);
%% plot extracted neuron
figure;
plot_neuron(solution_by_ilp)
axis('off')
%xlim([0 res]);
%ylim([0 res]);

%% show & save video
close all;
data = D1(border(1):border(2),border(3):border(4),:,:)/256;
%data = D2(1:238,120:421,:);
%data = D2(1:300,50:370,:);
%data = D2;
frames_input = frames;
H_input = H; 
x_input = x_detect-border(3);
y_input = y_detect-border(1);
t_input = t_detect;
plot_detections = 1;
plot_neuron_b = 0;
plot_recording = 1;
pause_step = -1.1;
save_video = 0;
name = 'neuron_1_spantanous_1';
F = plot_moving_detections(data, frames_input, H_input, x_input, y_input, ...
    t_input, plot_detections, plot_neuron_b, plot_recording, pause_step, save_video, name, solution_by_ilp);
close all;
%%

close all
hold on
I = find(cc_par(H.Ebar.par)~=0);

scatter(x_detect, y_detect, 50,t_detect-min(t_detect),'filled')
axis([border(3),border(4),border(1),border(2)])
axis('off')
hold on
%%
I = i:length(x_detect);
%imagesc(-mean(abs(D2(10:end-10,10:end-10,146:184)),3))
%scatter(x_detect-border(3), y_detect-10, 1*(amp_detect-min(amp_detect)+.01), zeros(size(t_detect)),'filled')
scatter(x_detect(I), y_detect(I), 50, t_detect(I)-min(t_detect),'filled')
%hold on
plot_neuron(solution_by_ilp, 'k')
%axis('off')
axis([border(3),border(4),border(1),border(2)])
axis('off')
%axis('equal')
%%
close all
a = flipud(squeeze(min(D2(border(1):border(2),border(3):border(4)-0,frames),[],3)));
a(a<-30) = -30;
a(a>10) = 10;
a = -a-20;
%a(1,1) = -30;
imagesc(a)
%colormap('gray')
%%
surf(a)
%%
%surf(D(:,:,1))
surf(squeeze(D2(220:410,150:300,70))/256);
%surf(squeeze(mean(D1(:,:,:,42),3))/256)
%colormap summer
shading interp
%%
i = 6;
imagesc(squeeze(D2(:,:,i)));
hold on;
%scatter(x_detect_1(t_detect_1==i), y_detect_1(t_detect_1==i),'.')
%amp_detect_1(t_detect_1==i)
%%
figure;
frame_time = frames(1:8:end);
count = 0;
columns = 5;
rows = floor(length(frame_time)/columns)+1;
index = reshape(1:rows*columns, columns, rows).';
for i=1:length(frame_time)
    t_i = frame_time(i);
    subplot(rows,columns,i)
    i
    imagesc(squeeze(D1(border(1):border(2),border(3):border(4),:,t_i)));
    I = find(t_detect==t_i);
    title(t_i)
    hold('on')
    scatter(x_detect(I)-border(3), y_detect(I)-border(1),'*','k');
    axis('off')
    %xlim([0 res]);
    %ylim([0 res]);
    %count = count+1;
end

%%
% clc
% x = 10*rand(1,4);
% y = 10*rand(1,4);
% t = [1,1,2,3];
% x = x - x(1);
% y = y - y(1);
%
% W = sparse(4,4);
% % for i =1:3
% %    W(i,i+1) = 1;
% %     W(i+1,i) = 10;
% %     W(i+2,i) = 1;
% % end
%
% W(2, 1) = 1;
% %W(3,1) = 1;
% W(3,2) =1;
% W(4,3) =1;
% W(find(W~=0))=rand(length(find(W~=0)),1);
% full(W)
% %W( 1,2) = 1;
% %W(1,3) = 1;
% %W(2,3) =1;
% %W(3,4) =1;
%
% H = ilp_for_detctions(x, y, t, W);
% H.Ebar.par


%%
x_detect = x1;
y_detect = y1;
amp_detect = ones(1,length(x1));
ind = find(par~=0);
scatter(x_detect(ind), y_detect(ind),100*abs(amp_detect(ind)),'.')
hold on
for i=1:length(ind)
    loc = ind(i);
    par_loc = par(ind(i));
    plot([x_detect(loc), x_detect(par_loc)],[y_detect(loc), y_detect(par_loc)]);
    hold on;
end

%% frames
figure;
frame_time = 185:195;
count = 0;
columns = 3;
rows = length(frame_time)/columns;
index = reshape(1:rows*columns, columns, rows).';
for i=frame_time
    index_plot = index(i-30)-1;
    subplot(rows,3*columns,3*index_plot+1)
    imagesc(transpose(D1(:,res:-1:1,i)));caxis([-8 4]);
    [a, b] = find(abs(D1(:,:,i))>.5);
    title(i)
    axis('off')
    subplot(rows,3*columns,3*index_plot+2)
    scatter(a, b,'.');
    
    [idx,C] = kmeans([a,b],20);
    subplot(rows,3*columns,3*index_plot+3)
    scatter(C(:,1),C(:,2),'.');
    xlim([0 res]);
    ylim([0 res]);
    count = count+1;
end

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
%% Test Data
%clear
clc
[X,Y,Z] = meshgrid(0:1/(400-1):1,0:1/(400-1):1,1);
X = reshape(X,1,400*400);
Y = reshape(Y,1,400*400);
Z = reshape(Z,1,400*400);
neuron_data = rand(4,65);
neuron_data(4,:) = .95;
neuron_data(1,:) = 1;
D = reshape(evalpotential([X;Y;Z],neuron_data),400,400);
D = (D - min(min(D)))./(max(max(D)) - min(min(D)));
res = 400;
imagesc(D)
%% Finding the sources
data = zeros(size(D1));
for i = 1:size(D2,3)
    D = D2(:,:,i);
    D = conv2(D,ones(6,6),'same');
    D = (D - min(min(D)))./(max(max(D)) - min(min(D)));
    data(:,:,i) = D;
end
%%
close all
amp_thrsh = 2;
conv_window = 4;
for i=1
    D = D2(:,:,i);
    hold on
    imagesc(D);caxis([-8 4]);
    [x, y, amp] = find_detetions_cmos(D,conv_window, amp_thrsh);
    [neg_x, neg_y, neg_amp] = find_detetions_cmos(-D,conv_window, amp_thrsh);
    x = [x; neg_x];
    y = [y; neg_y];
    scatter(x, y,'k','.')
    hold off
    pause(.05)
end





%%
conv_window = 6;
frame = 98;
image = D2(:,:,frame);
image = conv2(image,ones(conv_window,conv_window),'same');
p1=FastPeakFind(image);
p2=FastPeakFind(-image);
p = [p1;p2];
points = zeros(2, length(p)/2);
points(1,:) = p(1:2:end);
points(2,:) = p(2:2:end);

I = [];
for i = 1:size(points,2)
    if abs(image(points(1,i),points(2,i))) >8
        
        I = [I, i];
    end
end
size(I)
amp = image(sub2ind(size(image), points(2,:),points(1,:)));
points = points(:, I);
imagesc(D2(:,:,frame)); hold on;
%imagesc(image); hold on;
scatter(points(1,:), points(2,:),1*abs(amp(I)),'.')

%%
new_par = cc_par(par);
cost = 0;
for i=1:length(new_par)
    if new_par(i)~=0
        cost = cost + W(i, new_par(i));
    end
end
cost
%%
clc
W
find(cc_par(par))
new_par(find(cc_par(par)))
