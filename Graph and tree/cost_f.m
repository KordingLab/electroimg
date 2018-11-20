function W = cost_f(x,y,amp,time, consecuatve_frames, edge_coff, threshold_dis_connect, threshold_amp, cost)

number_of_detections = size(x,1);
W = sparse(number_of_detections, number_of_detections);

locations = transpose([x,y]);
W = sparse(number_of_detections, number_of_detections);
max_time = max(time);
for s=1:consecuatve_frames
    for i = s+min(time):max_time
        t_i = find(time == i);
        t_i_1 = find(time == i-s);
        for j = t_i
            for k = t_i_1
                
                distance_edge = sqrt(sum((locations(:,j)-locations(:,k)).^2));
                
                eu_distance_amp = abs((amp(j)-amp(k)));
                log_distance_amp = abs(log(abs(amp(j)))-log(abs(amp(k))));
                same_sign_amp = sign(amp(j)*amp(k));
                if i == 1+min(time)
                    same_sign_amp = 1;
                end
                if strcmp(cost, 'distance')
                    if distance_edge<threshold_dis_connect*s
                        if same_sign_amp==1
                            W(j,k) = (threshold_dis_connect- distance_edge)/s + ...
                                0*(30-1*eu_distance_amp) + 0*log_distance_amp +...
                                (s-1)*0;
                            if(abs(amp(j)>10 && abs(amp(i))>10))
                                 W(j,k) =  W(j,k) +threshold_amp;
                            end
                        end
                    else
                        
                        W(j,k) = 0;
                    end
                else
                    if strcmp(cost, 'constant')
                        if distance_edge<threshold_dis_connect
                            W(j,k) = .1;
                        else
                            W(j,k) = 0;
                        end
                    end
                end
            end
        end
    end
end