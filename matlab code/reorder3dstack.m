function out = reorder3dstack(X,szx,szz)

X(:,1)=[];
X(1,:)=[];

numt = size(X,2);

out = zeros(szz,szx,numt);
for i=1:numt 
    out(:,:,i) = reshape(X(:,i),szz,szx);
end
    
end