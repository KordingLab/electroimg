function F = plot_moving_detections(data, frames, H, x, y, t, plot_detections,...
    plot_neuron_b, plot_recording, pause_step, save_video, name, ground_truth)
close all;
res = size(data);
if plot_neuron_b>0
    par = H.Ebar.par;
    par = one_cc_tree(par);
    detections = find(par~=0);
else
    detections = 1:length(x);
end
existing_node = 0;
existing_par_node = 0;

F = cell(length(frames),1);
all_detect = [];
lines_x_1 = [];
lines_y_1 = [];
lines_x_2 = [];
lines_y_2 = [];
c_frame = 1;
for i=frames
    hold on
    title([int2str(i)])
    if plot_recording
        if length(size(data))==2
           image([0,1,0],[0,1,1],[255,255,255]);
           colormap('gray')
           
           %colormap('gray')
           %plot(1,1)
        end
        if length(size(data))==3
            imagesc(squeeze(data(:,:,i))); %caxis([-10 5]);
            caxis([-35 10]);
        end
        if length(size(data))==4
            imagesc(squeeze(data(:,:,:,i))); %caxis([-10 5]);
            %caxis([-35 10]);
        end
        
    end
    if plot_detections == 1
        
        a_d = find(t==i);
        detect_t = intersect(detections, a_d);
        all_detect = [all_detect; detect_t];

        scatter(x(a_d), y(a_d), '.', 'red')
        
    end
    
    if plot_neuron_b == 1
        
        for j=1:length(detect_t)
            node = detect_t(j);
            par_node = par(node);
            
            lines_x_1 = [lines_x_1, x(node)];
            lines_x_2 = [lines_x_2, x(par_node)];
            
            lines_y_1 = [lines_y_1, y(node)];
            lines_y_2 = [lines_y_2, y(par_node)];
            
        end
        
        %plot_neuron(ground_truth, 'cyan')
        line([lines_x_1;lines_x_2], [lines_y_1;lines_y_2],'Color','black')
        
        scatter(x(all_detect), y(all_detect), '.', 'black')
        %hold off
        
        
    end
    
    
    xlim([0 res(2)]);
    ylim([0 res(1)]);
    
    
    
    if save_video
        F{c_frame} = getframe(gcf);
    else
        
        drawnow
        hold off
        if pause_step < 0
            pause
        else    
        pause(pause_step)
        end
    end
    c_frame = c_frame + 1;
    
end

if save_video
    writerObj = VideoWriter(strcat(name,'.avi'));
    writerObj.FrameRate = 15;
    writerObj.Quality = 100;
    open(writerObj);
    for u=1:length(F)
        frame = F{u};
        %for v=1:length(F)
        writeVideo(writerObj, frame)
        %end
    end
    close(writerObj);
    
end