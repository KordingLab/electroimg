function [x, y, amp] = extrema(image, amp_thrsh, conv_window )

image_refine = conv2(image,ones(conv_window,conv_window),'same')/conv_window^2;

p1=maxima(image_refine);
p2=maxima(-image_refine);
p = [p1;p2];
x = p(1:2:end);
y = p(2:2:end);
amp = image(sub2ind(size(image), y, x));
amp2 = image(sub2ind(size(image_refine), y, x));
I = find(abs(amp)>amp_thrsh);
x = x(I);
y = y(I);
amp = amp2(I);


%%%%%%%%%%%%%   An Alternative method by watershed idea %%%%%%%%%%%
%
%     step_size = .1;
%     max_sqr = 40;
%
%
%     image2 = conv2(image,ones(conv_window,conv_window),'same');
%     image2 = (image2 - min(min(image2)))./(max(max(image2)) - min(min(image2)));
%     level = min(min(image));
%
%     x = [];
%     y = [];
%     amp = [];
%     res = size(image);
%     all_basin = cell(0,0);
%     im = sign(sign(image2-level)+1);
%     comp = bwconncomp(im);
%     comp = comp.PixelIdxList;
%     for i=1:length(comp)
%         b = struct;
%         b.basin = comp{i};
%         b.threshold = level;
%         all_basin{end+1} = b;
%     end
%
%     while length(all_basin)>0
%         b = all_basin{1};
%         im = zeros(res);
%         index = b.basin;
%         l = b.threshold;
%         new_l = l + step_size;
%         im = zeros(size(image2));
%         im(index) = image2(index);
%         im = sign(sign(im-new_l)+1);
%
%         [I,J] = ind2sub(res,index);
%         if sum(sum(im)) == 0 & length(index)>0  & max(I)-min(I)<max_sqr & max(J)-min(J)<max_sqr % & length(index)<2000
%             x = [x; mean(J)];
%             y = [y; mean(I)];
%             amp = [amp; mean(image(index))];
%
%         else
%             comp = bwconncomp(im);
%             comp = comp.PixelIdxList;
%             for i=1:length(comp)
%                 b = struct;
%                 b.basin = comp{i};
%                 b.threshold = new_l;
%                 all_basin{end+1} = b;
%             end
%         end
%         all_basin = all_basin(2:end);
%     end
%
%     x = x(abs(amp)>amp_thrsh);
%     y = y(abs(amp)>amp_thrsh);
%     amp = amp(abs(amp)>amp_thrsh);




% W = zeros(length(time),length(time));
% for i=1:length(frames)
%     t_i = find(time == i);
%     t_i_1 = find(time== i-1);
%     for j = t_i
%         for k = t_i_1
%             W(j,k) = (sqrt(sum((locations(:,j)-locations(:,k)).^2))/400)^1.5;
%         end
%     end
% end