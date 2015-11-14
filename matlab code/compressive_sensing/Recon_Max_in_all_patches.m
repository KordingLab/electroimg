function [MaxPosition,MinPosition] = Recon_Max_in_all_patches(Frec)
% Frec is the a collection of all patchs. Here size of each patch are set
% to 30*30*30 and they overlap in half.
% MaxPos and MinPos are location of local maximums and minimums in all
% patchs
MaxPosition = [];
MinPosition = [];
P = 30;
Q = 25;

for i=1;
    
    for j=1:4;
        
        for k=1:5;
            z = Frec{i,j,k};
            out = convn_fft(z,ones(4,4,4));
            [Maxima,Maxpos,Minima,Minpos]=MinimaMaxima3D(out,1,0);
            a = size(Maxpos,1);
            Maxpos = [(i-1)*Q*ones(a,1),(j-1)*Q*ones(a,1),(k-1)*Q*ones(a,1)] + Maxpos;
            MaxPosition = [MaxPosition;Maxpos];
            a = size(Minpos,1);
            size([(i-1)*Q*ones(a,1),(j-1)*Q*ones(a,1),(k-1)*Q*ones(a,1)]);
            Minpos = [(i-1)*Q*ones(a,1),(j-1)*Q*ones(a,1),(k-1)*Q*ones(a,1)] + Minpos;
            MinPosition = [MinPosition;Minpos];
        end
    end
end