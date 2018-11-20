%% Reading real data
clear
clc
movie2 = 'Culture 2 Movie 2 (100926-A2-StimScan-Data).mat';
movie3 = 'Culture 3 Movie 2 (091123-A-StimScan-Data).mat';
movie4 = 'Culture 4 Movie 2 (091120-B-StimScan-Data).mat';
load(strcat('/Volumes/Arch/Google Drive/Projects/Electrical Imaging/CMOS Data/raw data/',movie2))
[X,Y,Data,A] = read_CMOS(data);
sdata = squeeze(mean(Data,1));
%Data = Normal_over_time(A);

%Data = Normal_over_time(sdata(:,:));
%%
J = find(max(abs(X-1000),abs(Y-1000))<3000);
%Movie_CMOS(1*squeeze(mean(Data(1:30,J,65:179),1)),X(J),Y(J),2)'
sdata = squeeze(mean(Data,1));
[D1,s] = Movie_CMOS(1*sdata(J,1:end),X(J),Y(J),2, 400);
%res = 400;
D2 = D1;
D2(isnan(D2)) = 0;
%clear data I J X Y sdata A
%% Make mesh
delta_x = 16.2000; %unique(diff(unique(sort(X))))
delta_y = 9.7940; %unique(diff(unique(sort(Y))))

min_x = 175.5; %min(X)
max_x = 1908.9;
min_y = 98.123;  %min(Y)
max_y = 2096.1;
step_y = floor((max_y-min_y)/delta_y);
sites = [];
index_on_probs = [];
closest_index_on_probs = [];
for i_y=1:2:2*step_y
    for i_x = 0:i_y
        y_loc = delta_y*(i_y-i_x) + min_y;
        x_loc = delta_x*i_x + min_x;
        if y_loc < max_y+.1 && x_loc < max_x+.1
            sites = [sites; [x_loc, y_loc]];
            [i,j] = min(abs(X-x_loc)+abs(Y-y_loc));
            closest_index_on_probs = [closest_index_on_probs, j];
            if(i<.2)
                index_on_probs = [index_on_probs, j];
            else
                index_on_probs = [index_on_probs, 0];
            end
        end
    end
end
%% fill missing data
sX = sites(:,1);
sY = sites(:,2);
sData = Data(:, closest_index_on_probs, :);
mData = squeeze(mean(sData,1));
%%
mData = squeeze(sData(2, :, :));
%%
close all
figure;
for i = 71:200
    %plot(mData(:,i))
    plot(squeeze(sData(2,:,i)))
    xlim([0, 12000])
    ylim([-200, 200])
    pause(.05)
end
%%
I = zeros(length(sX),1);
for i=1:length(sX)
    x_loc = sX(i);
    y_loc = sY(i);
    I(i) = length(find(sqrt((sX-x_loc).^2+abs(sY-y_loc).^2)<60));
end
J = sort(I);
J(end)

%%
vic_mat = zeros(length(sX),37);
non_border = [];
for i=1:length(sX)
    x_loc = sX(i);
    y_loc = sY(i);
    vic = find(sqrt((sX-x_loc).^2+abs(sY-y_loc).^2)<60);
    if length(vic)==37
        vic_mat(i,:) = vic;
        non_border = [non_border, i];
    end
end
%%
close all
figure;
index = non_border(1500);
for i = 71:200
    scatter(sX(vic_mat(index,:)), sY(vic_mat(index,:)), 400*abs(mData((vic_mat(index,:)), i)),'.')
    pause(.01)
end
%%
obs = [];
obs_time = [];
obs_ind = [];
for t = 1:30
    local_obs = [];
    
    for j = 1:1
        for i=1:37
            local_obs = [local_obs, mData(vic_mat(non_border, i),70+t+j)];
            
        end
    end
    obs_time = [obs_time; t*ones(length(non_border), 1)];
    obs_ind = [obs_ind; transpose(non_border)];
    obs = [obs;local_obs];
end
%%
above_threshold = find(max(abs(transpose(obs)))>20);
%%
[eig_vec,eig_basis,eig_val] = princomp(zscore(obs(above_threshold, :)));
%%
PC1 = zeros(length(sX), 30);
n = length(non_border);
for k = 1:length(above_threshold)
    i = above_threshold(k);
    time_i = obs_time(i);
    ind = obs_ind(i);
    if abs(eig_basis(k,1))>0
        PC1(ind, time_i) = eig_basis(k,1); %eig_basis(k,2)/eig_basis(k,1);
    end
end
%%
close all
figure(1);
F = cell(30,1);
for i = 1:30
    scatter(sY,sX, 40,10*abs(squeeze(PC1(:,i)))+.1, 'filled')
    
    ylim([min_x max_x]);
    xlim([min_y max_y]);
    pause(.01)
    F{i} = getframe(gcf);
end
%%
    writerObj = VideoWriter(strcat('pca_basis','.avi'));
    writerObj.FrameRate = 15;
    open(writerObj);
    for u=1:length(F)
        frame = F{u};
        %for v=1:length(F)
            writeVideo(writerObj, frame)
        %end
    end
    close(writerObj);
%%
scatter(eig_basis(:,1), eig_basis(:,2), '.'); xlabel('PC1');ylabel('PC2');
%%
scatter(sX(vic_mat(non_border(1),:)), sY(vic_mat(non_border(1),:)), 4000, eig_vec(:,3),'filled')
%%
close all
figure(2);
for i = 1:30
    scatter(sY,sX, 25, squeeze(mean(sData(1:30,:,50+i),1)), 'filled')
    caxis([-15,10])
    pause(.001)
end


%%
x_detect_1 = [];
y_detect_1 = [];
t_detect_1 = [];
amp_detect_1 = [];
for i=min(t_detect):max(t_detect)
    I = find(t_detect==i);
    Z = linkage([x_detect(I)/256,y_detect(I)/256, amp_detect(I)/25], 'ward');
    c = cluster(Z,'Cutoff',.05,'Criterion','distance');
    
    for j=1:max(c)
        
        J = find(c==j);
        x_detect_1(end+1) = mean(x_detect(J));
        y_detect_1(end+1) = mean(y_detect(J));
        amp_detect_1(end+1) = mean(amp_detect(J));
        t_detect_1(end+1) = i;
    end
end
%scatter3(X(:,1),X(:,2),X(:,3),10,c)














