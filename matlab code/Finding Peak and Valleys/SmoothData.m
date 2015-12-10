function D = SmoothData(elec_data,width,type)
% elec_data is 3D data of electrical activities. to find a better resolution
% of data, it is convolved by a smooth window. this could be constant (if
% type ==1) of Gaussian (if type == 2) with the width of width (argument).
% Output is the Min and Max positions.

if(type==1)
    Con = ones(width,width,width);
elseif(type==2)
    n = size(width,2);
    [X,Y,Z] = meshgrid(-2:4/n:2,-2:4/n:2,-2:4/n:2);
    Con = exp(-(X.^2+Y.^2+Z.^2)/width);
end
D = convn_fft(elec_data,Con);