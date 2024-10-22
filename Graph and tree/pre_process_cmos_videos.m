%% Pre-processing
clear
clc

v = VideoReader('/Volumes/Arch/Downloads/srep31332-s4.mov');
close all

%%
save_mode = 1;

if all(v.Name=='srep31332-s1.mov')
    n_frames = 240;
end
if all(v.Name=='srep31332-s2.mov')
    n_frames = 520;
end

if all(v.Name=='srep31332-s3.mov')
    n_frames = 1058;
end
if all(v.Name=='srep31332-s4.mov')
    n_frames = 653;
end
if save_mode==1
    D1 = zeros(530-43+1,520-100+1,3,n_frames);
    D2 = zeros(530-43+1,520-100+1,n_frames);
end
for i = 1:n_frames
    i
    a = read(v,i);
    
    b = rgb2hsv(a);
    
    hue = squeeze(b(:,:,1));
    lightness = squeeze(b(:,:,3));
    c = 32.5*(1-hue/.66)-30;
    
    b_abv_idx = find(hue > 0.66 );
    b_abv_idx_1 = b_abv_idx(find(hue(b_abv_idx) < 0.8 ));
    c(b_abv_idx_1) = 5*(lightness(b_abv_idx_1)-.83)/.17 - 35;
    b_abv_idx_2 = b_abv_idx(find(hue(b_abv_idx) > 0.8 ));
    c(b_abv_idx_2) = 7.5*(1-(lightness(b_abv_idx_2)-.66)/.34)+2.5;
     
    
    if save_mode==1
        D1(:,:,:,i) = a(43:530,100:520,:);
        D2(:,:,i) = c(43:530,100:520);
    else
                subplot(2,1,1)
                imagesc(a(43:530,100:520,:))
                subplot(2,1,2)
                imagesc(c(43:530,100:520))
        
        
        %         subplot(2,1,1)
        %         imagesc(a(220+43:530,150+100:520,:))
        %         subplot(2,1,2)
        %         imagesc(c(220+43:530,150+100:520))
        pause
    end
end


if save_mode==1
    D1 = flip(D1(:,:,:,:),1);
    D2 = flip(D2(:,:,:,:),1);
    save(v.Name, 'D1', 'D2', '-v7.3');
end
