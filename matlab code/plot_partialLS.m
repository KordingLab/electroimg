function plot_partialLS(LSest,dims,zcoord,correct_z)

% plot partial LS estimates
for i=1:length(zcoord) 
    subplot(ceil(length(zcoord)/5),5,i); 
    imagesc(reshape(LSest(:,i),dims(1),dims(2))); 
    
    ell0_energy = norm(LSest(:,i),1);
    plot_title = ['Depth = ', num2str(zcoord(i)), ', L0 = ' num2str(ell0_energy,2)];
    
    if nargin>3
        if zcoord(i)==correct_z
            plot_title = [plot_title, ' (Correct Plane)'];
        end
    end
    
    title(plot_title) 
end