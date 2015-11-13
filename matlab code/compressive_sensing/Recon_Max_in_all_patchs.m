function [MaxPosition,MinPosition] = Recon_Max_in_all_patchs(Frec)
% Frec is the a collection of all patchs. Here size of each patch are set
% to 30*30*30 and they overlap in half.
% MaxPos and MinPos are location of local maximums and minimums in all
% patchs
MaxPosition = [];
MinPosition = [];
for i=1:3;
    for j=1:6;
        for k=1:7;
            z = Frec{i,j,k};
            out = convn_fft(z,ones(3,3,3));
            [Maxima,MaxPos,Minima,MinPos]=MinimaMaxima3D(out,1,0);
            Maxpos = [(i-1)*15*ones(30,1),(j-1)*15*ones(30,1),(k-1)*15*ones(30,1)] + Maxpos;
            Maxposition = [Maxposition;Maxpos];
            Minpos = [(i-1)*15*ones(30,1),(j-1)*15*ones(30,1),(k-1)*15*ones(30,1)] + Minpos;
            Minposition = [Minposition;Minpos];
        end
    end
end