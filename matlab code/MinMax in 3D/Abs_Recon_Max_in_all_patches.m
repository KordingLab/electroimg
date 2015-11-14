function [MaxPosition,MinPosition] = Abs_Recon_Max_in_all_patches(Frec,th)
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
            [I,J,K] = ind2sub([30,30,30],find(out>th));
            Maxpos = [I,J,K];
            a = size(Maxpos,1);
            MaxPosition = [(i-1)*Q*ones(a,1),(j-1)*Q*ones(a,1),(k-1)*Q*ones(a,1)] + Maxpos;
        end
    end
end