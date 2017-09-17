function G=pre_process_stage2(G)

%G definition
%G.subt2det
%G.M_sub2det
%G.subt2det_end
%G.subt2det_end
G.dock=[];
G.dock.pre2sub=cell(G.NJ,1);
G.dock.post2sub=cell(G.NJ,1);
G.dock.start_doc_2_sub=cell(G.ND,1);
G.dock.end_doc_2_sub=cell(G.ND,1);
for(s=1:G.NS)
    v1=G.S.pre_fix_ind(s);
    v2=G.S.post_fix_ind(s);
    v3=G.S.dock_start_ind(s);
    v4=G.S.dock_end_ind(s);
    G.dock.pre2sub{v1}=[G.dock.pre2sub{v1},s];
    G.dock.post2sub{v2}=[G.dock.pre2sub{v2},s];
    if(v3>0.5)
        G.dock.pre2sub{v3}=[G.dock.pre2sub{v3},s];
    end
    if(v4>0.5)

        G.dock.post2sub{v4}=[G.dock.post2sub{v4},s];
    end
end

G.dyn=[];
G.dyn.pred=cell(G.NS,1);
for(s=1:G.NS)
    
    pred_ind=G.S.pre_fix_ind(s);
    G.dyn.pred{s}=G.dock.post2sub{pred_ind};
end