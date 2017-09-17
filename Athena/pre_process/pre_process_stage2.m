function G=pre_process_stage2(G)

%G definition
%G.sub2det
%G.M_sub2det
%G.sub2det_end
%G.sub2det_end

pred_list=cell(G.Ns,1);

G.dock.pre2sub=cell(G.NJ,1);
G.dock.post2sub=cell(G.NJ,1);
G.dock.start_doc_2_sub=cell(G.ND,1);
G.dock.end_doc_2_sub=cell(G.ND,1);
for(s=1:G.Ns)
    v1=G.sub.pre_fix(s);
    v2=G.sub.pre_fix(s);
    v3=G.sub.start_doc(s);
    v3=G.sub.end(s);
    G.dock.pre2sub{v1}=[G.pre2sub{v1},s];
    G.dock.post2sub{v2}=[G.pre2sub{v2},s];
    if(v3>0.5)
        G.dock.post2sub{v3}=[G.pre2sub{v3},s];
    end
    if(v4>0.5)

        G.dock.post2sub{v4}=[G.pre2sub{v4},s];
    end
end
