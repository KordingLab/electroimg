function lineage=get_lineage(G,primal_int_sol)
%primal_int_sol
%pause
sub_sum=sum(primal_int_sol.sub,2);
if(max(sub_sum)>1.0001)
    disp('yuck')
    pause
end
inds_flag=find(sub_sum>0.5);
v1=G.S.D(inds_flag,2);
v2=ones(numel(inds_flag),1);
v3=G.S.D(inds_flag,1);

if ( numel(unique(v1))~=numel(v1)  )
    disp('bad issue here')
    jy_out_val('numel(unique(v1))',numel(unique(v1)))
    jy_out_val('numel((v1))',numel((v1)))
    disp('bad issue here')

    pause
end

lineage=sparse(v1,v2,v3,G.N,1);
inds_include=sum(primal_int_sol.X,2);
inds_include=double(inds_include>0.5);
tmp1=double(lineage>0.5);
tmp1(1)=0;
inds_include(1)=0;
if(sum(abs(tmp1-inds_include)>0.5))
    disp('error here ')
    jy_out_val('sum(tmp1>0.1+inds_include)',sum(tmp1>0.1+inds_include))
    jy_out_val('sum(tmp1+0.1<inds_include)',sum(tmp1+0.1<inds_include))

    jy_out_val('sum(abs(tmp1-inds_include)>0.5)',sum(abs(tmp1-inds_include)>0.5))
    pause
end
%(lineage).*inds_include