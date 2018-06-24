function G=get_graph_struct(G)

B=[];
[~,B.old_2_new_order]=sort(G.F.time);
[~,B.new_2_old_order]=sort(B.old_2_new_order);

B.N=numel(B.old_2_new_order);
B.W=G.F.W(B.old_2_new_order,B.old_2_new_order);

B.E_ind_on=find(abs(B.W)>G.params.epsilon);
[i1,i2]=ind2sub([B.N,B.N],B.E_ind_on);
B.EI=[i1,i2];
inds_flip=find(B.EI(:,1)>B.EI(:,2));
B.EI(inds_flip,:)=B.EI(inds_flip,[2,1]);
if(sum(B.EI(:,1)==B.EI(:,2)))
    disp('BAD BAD')
    pause
end

B.NE=numel(B.E_ind_on);
B.theta=B.W(B.E_ind_on);

B.par_list=cell(B.N,1);
B.kid_list=cell(B.N,1);
B.num_kids=zeros(B.N,1);
B.num_pars=zeros(B.N,1);

for(e=1:B.NE)
    
    i1=B.EI(e,1);
    i2=B.EI(e,2);
    
    if(i1>i2)
        
        tmp=i1;
        i1=i2;
        i2=tmp;

    end
    B.par_list{i2}=[B.par_list{i2},i1];
    B.kid_list{i1}=[B.kid_list{i1},i2];

    B.num_kids(i1)=B.num_kids(i1)+1;
    B.num_pars(i2)=B.num_pars(i2)+1;
        
    
end
B.no_par_list=find(B.num_pars<0.5);
G.B=B;
disp('at end')
G
disp('at he')
