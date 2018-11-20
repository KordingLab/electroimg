function [x_detect, y_detect, amp_detect, t_detect] = find_all_detections(data,...
    frames, amp_thrsh, conv_window, cutoff, rm_x, rm_y, rm_t, rm_radius)
%%%%%%%%% Finding Local Minima/Maxima for all frames %%%%%%%%%%%

x = [];
y = [];
t = [];
amp = [];
for f= frames
    image = squeeze(data(:,:,f));
    [x_f, y_f, amp_f] = extrema(image, amp_thrsh, conv_window);
    x = [x; x_f];
    y = [y; y_f];
    amp = [amp; amp_f];
    
    t = [t; f*ones(length(x_f),1)];
    
end

x_detect = [];
y_detect = [];
t_detect = [];
amp_detect = [];
for i=frames
    
    I = find(t==i);
    if i>rm_t
        
        I = I(find(sqrt(sum((x(I)-rm_x).^2 + (y(I)-rm_y).^2, 2))>rm_radius));
    end
    if length(I)>1 
        Z = linkage([x(I), y(I), amp(I)], 'ward');
        c = cluster(Z,'Cutoff',cutoff,'Criterion','distance');
    else
        c = 1;
    end
    for j=1:max(c)
        
        J = find(c==j);

        x_detect(end+1) = mean(x(I(J)));
        y_detect(end+1) = mean(y(I(J)));
        amp_detect(end+1) = mean(amp(I(J)));
        t_detect(end+1) = i;
    end
end

[~, argsort] = sort(t_detect);
t_detect = transpose(t_detect(argsort));
x_detect = transpose(x_detect(argsort));
y_detect = transpose(y_detect(argsort));
amp_detect = transpose(amp_detect(argsort));

