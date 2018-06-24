function desc=sol2desc(G,sol)

desc.sol=sol;
desc.e_act=find(sol>0.5);

desc.n_par=zeros(G.B.N,1);
desc.n_kid=zeros(G.B.N,1);
desc.par=zeros(G.B.N,1);
desc.kids=cell(G.B.N,1);
desc.kids_mat=zeros(G.B.N,2);

for(e=desc.e_act(:)')
    
    i1=G.B.EI(e,1);
    i2=G.B.EI(e,2);
    
    desc.n_par(i2)=1;
    desc.par(i2)=i1;
    desc.n_kid(i1)=desc.n_kid(i1)+1;
    desc.kids{i1}=[desc.kids{i1}];
    if(desc.n_kid(i1)<1.5)
        desc.kids_mat(i1,1)=i2;
    else
        desc.kids_mat(i1,2)=i2;
    end
    
end