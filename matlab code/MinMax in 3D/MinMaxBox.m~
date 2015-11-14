function Index = MinMaxBox(Input,d)
% output is the rank of each array in a cube of lenght d. To find loca maxmium wright: find(Index == d^3-1). 
x = size(Input,1);
y = size(Input,2);
z = size(Input,3);
Index = zeros(x+2*d+1,y+2*d+1,z+2*d+1);
J = zeros(x+2*d+1,y+2*d+1,z+2*d+1);
J(d+1:x+d,d+1:y+d,d+1:z+d) = Input;
Input = J;
for i = -d:d
    for j = -d:d
        for k = -d:d
            J = zeros(x+2*d+1,y+2*d+1,z+2*d+1);
            J(d+i+1:x+d+i,d+j+1:y+d+j,d+k+1:z+d+k) = Input(d+1:x+d,d+1:y+d,d+1:z+d);
            J = Input - J;
            J = (sign(J)+1)/2;
            Index = Index + J;
        end
    end
end
Index = Index - .5;
Index(1:d,:,:)=0;
Index(:,1:d,:)=0;
Index(:,:,1:d)=0;
Index(end-d:end,:,:)=0;
Index(:,end-d:end,:)=0;
Index(:,:,end-d:end)=0;

