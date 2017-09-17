function G=pre_process_stage1(F,params)

%portion docks make
G=[];
G.F=F;


join_list=unique([F.dets(:,1:end-1);F.dets(:,2:end)],'rows');

dock_list=join_list(randperm(size(join_list,1)));
n_keep=params.por_dock*size(join_list,1));
dock_list=dock_list(1:n_keep,:);
G.join_list=join_list;
G.dock_list=dock_list;
G.sub.sub_list=F.dets;
G.sub.last_det=F.dets(:,end);
G.sub.pre_fix=F.dets(:,1:end-1);

[~,G.sub.pre_fix_ind]=ismember(G.sub.pre_fix,join_list,'rows');
[~,G.sub.post_fix_ind]=ismember(G.sub.post_fix,join_list,'rows');
[~,G.sub.dock_start_ind]=ismember(G.sub.pre_fix,dock_list,'rows');
[~,G.sub.dock_end_ind]=ismember(G.sub.post_fix,dock_list,'rows');
G.sub.post_fix=F.sub(:,2:end);
G.sub.starts_soma=F.starts_soma=D(:,1);
G.sub.start_cost=F.start_cost=D(:,2);
G.sub.term_cost=F.term_cost=D(:,3);
G.sub.cost=F.cost;

G.N=max(max(F.dets));
G.NS=size(G.sub,1);
G.ND=size(G.dock_list,1);
G.NJ=max(G.join_list,1);

G=pre_process_stage2(G);
