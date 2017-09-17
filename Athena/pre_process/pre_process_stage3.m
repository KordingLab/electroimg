function G=pre_process_stage3(G)

G.M=[];

v2=G.S.D(:);
v1=jy_copy_col([1:G.NS],G.LS);
v3=0*v2+1;

G.M.sub2det=sparse(v1,v2,v3);

v1=[1:G.NS]';
v2=G.S.dock_start_ind;
v3=0*v1+1;%+(G.S.dock_start_ind>0.5);

v1=v1(v2>0.5);
v2=v2(v2>0.5);
v3=v3(v2>0.5);


G.M.sub_start_doc=sparse(v1,v2,v3,G.NS,G.ND);



v1=[1:G.NS]';
v2=G.S.dock_end_ind;
v3=0*v1+1;%(G.S.dock_e_ind>0.5);

v1=v1(v2>0.5);
v2=v2(v2>0.5);
v3=v3(v2>0.5);


G.M.sub_end_doc=sparse(v1,v2,v3,G.NS,G.ND);