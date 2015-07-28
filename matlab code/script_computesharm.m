%% import data from csv files
%currdir = pwd;
files = dir(fullfile('/Users/evadyer/Dropbox/ElectricalImaging/LFPy_PythonCode/generateLFData','*.csv'));

for i=1:length(files)
    Data{i} = csvread(['/Users/evadyer/Dropbox/ElectricalImaging/'...
        'LFPy_PythonCode/generateLFData/' files(i).name]);
end


[Data_full2,labels2,y2] = getfulldata(Data,files,thresh);



%% Create speherical harmonic basis
x = (-200:10:201);
z = (-200:10:301);
y = (-100:50:100);

degree=5;
for i=1:length(y)
    Basis{i} = normcol(createshbasis(x,z,y(i),degree));
end

D=[];
for i=1:length(Basis)
    D = [D Basis{i}];
end

N = size(Data_full,2);

%% decompose observations in terms of SH basis (using proj)
kmax = 10;

CoefSH = D'*Data_full;

for i=1:N
    [val,id] = sort(abs(CoefSH(:,i)),'descend');
    tmp = zeros(size(CoefSH,1),1);
    tmp(id(1:kmax)) = CoefSH(id(1:kmax),i);
    CoefSH(:,i) = tmp;
end

labels_sh = kmeans(CoefSH',5);

G = D'*D;
CoefSH_OMP = omp(D'*Data_full,G,kmax);


labels_shomp = kmeans(CoefSH_OMP',5);



%% learn PCA basis

L = 10;
[U,S,V] = svds(Data_full,L);
Basis_PCA = U;

CoefPCA = S*V';

labels_pca = kmeans(CoefPCA',5);



%% SEED BASIS

[ outs1 ] = nystrom( normcol(CoefOMP)'*normcol(CoefOMP), 30, 'p');
Basis_SEED1 = normcol(Data_full(:,outs1.selection));

G = Basis_SEED1'*Basis_SEED1;
CoefSEED1 = omp(Basis_SEED1'*Data_full,G,kmax);


[ outs2 ] = nystrom( normcol(Data_full)'*normcol(Data_full), 30, 'p');
Basis_SEED2 = normcol(Data_full(:,outs1.selection));

G = Basis_SEED2'*Basis_SEED2;
CoefSEED2 = omp(Basis_SEED2'*Data_full,G,kmax);


figure; 
for i=1:30; 
    subplot(6,5,i); 
    imagesc(reshape(Data_full(:,outs1.selection(i)),51,41)); 
end

figure; 
for i=1:30; 
    subplot(6,5,i); 
    imagesc(reshape(Data_full(:,outs2.selection(i)),51,41)); 
end




    




    

