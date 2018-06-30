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
    
    desc.kids{i1}=[desc.kids{i1},i2];
    if(desc.n_kid(i1)<1.5)
        desc.kids_mat(i1,1)=i2;
    else
        desc.kids_mat(i1,2)=i2;
    end
    if(desc.n_kid(i1)>2.5 && i1>1.5)
        disp('TOO MANY KIDS')
        i1
        i2
        
        jy_out_val('desc.kids{i1}',desc.kids{i1})
        pause
    end
    
end

desc.full_sol=[desc.sol(:);double(desc.n_kid>1.5)];

%if(numel(desc.sol(:))~=G.B.NE)
%    disp('bad hre')
%    pause
%end
%if(numel(double(desc.n_kid>1.5))~=G.B.N)
%   disp('diff bad here') 
%   pause
%end
%if(G.B.NE+G.B.N~=numel(desc.full_sol))
 %   disp('2diff bad here') 

%    pause
%end
jy_out_val('G.B.NE+G.B.N',G.B.NE+G.B.N)
jy_out_sz('(desc.full_sol)',desc.full_sol)
pause

desc.par_old=G.B.new_2_old_order(desc.par>0.5);
