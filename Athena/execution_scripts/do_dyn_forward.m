function T1=do_dyn_forward(G,dual_sol,T);

F=[];
F.red_cost=zeros(G.Ns,1);
F.cur_sub=cell(G.Ns,1);
F.cur_start=cell(G.Ns,1);
F.cur_det=cell(G.Ns,1);

start_cost=zeros(G.Ns,1);
start_cost(G.dock_list)=dual_sol.L2;
stop_cost=zeros(G.Ns,1);
stop_cost(G.dock_list)=dual_sol.L3;

for(s=G.forward_order_sub)
    
    pred_list=F.pred{s};
    cur_red_cost=inf;
    fin_det=G.sub_track_def(s,end);

    if(numel(pred_list)>0.5)
        red_list=F.red_cost(pred_list)+;
    %
    end
        start_red_cost=0;
    end
    if(G.is_start_dock(s)>0.5)
        start_red_cost=dual_sol.L2(s)+dual_sol.L3(s);
        start_red_cost=start_red_cost;
        if(start_red_cost<cur_red_cost)
            F.cur_sub{s}=[];
            F.cur_start{s}=s;
            F.cur_det{s}=[];
            F.red_cost(s)=start_red_cost;
        end
    end
    F.red_cost=F.red_cost+G.Theta(s)+dual_sol.L1(d);
    F.cur_sub=[F.cur_sub,s];
        
    
end
F.red_cost=red_cost-dual_sol.L2;
F.cur_fin=[1:G.Ns];


T_new=convert(G,F);

