function BPest = partial_BPestimates(p0,volcoord,gridcoord,zcoord,opts)

if nargin==4
    opts =[];
end

% read in options
if isfield(opts,'sigma')
    sigma = opts.sigma;
else
    sigma = 0.3;
end

if isfield(opts,'epsilon')
    epsilon = opts.epsilon;
else
    epsilon = 0;
end

if isfield(opts,'dims')
    dims = opts.dims;
else
    %error('Must specify dimension of grid!')
    dims = [51 41];
end

if isfield(opts,'visualize')
    visualize = opts.visualize;
else
    visualize = 1;
end

if isfield(opts,'iterations')
    options.iterations = opts.iterations;
else
    options.iterations = 100;
end

    
BPest = zeros(length(p0),length(zcoord));

for i=1:length(zcoord); 
    dict_fun = @(x,mode) fieldtocharge(x,mode,...
        volcoord,gridcoord,sigma,zcoord(i));
        
    BPest(:,i) = spg_bpdn(dict_fun,p0,epsilon,options);
           
    if visualize==1
        subplot(ceil(length(zcoord)/10),10,i); 
        imagesc(reshape(BPest(:,i),dims(1),dims(2))); axis square
        title(num2str(zcoord(i)))
        
        pause(0.1)
    end
    
end
    figure;
    plot_partialLS(BPest,dims,zcoord,1)

end
