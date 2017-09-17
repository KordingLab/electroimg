function G=pre_process_stage1(F,params)

%portion docks make
G=[];
G.F=F;
G.S=[];
G.C=[];

join_list=unique([F.dets(:,1:end-1);F.dets(:,2:end)],'rows');

dock_list=join_list(randperm(size(join_list,1)));
dock_list=unique([dock_list;join_list(1,:)],'rows');
n_keep=params.por_dock*size(join_list,1);
dock_list=dock_list(1:n_keep,:);
G.join_list=join_list;
G.dock_list=dock_list;
G.S.D=F.dets;
G.S.last_det=G.S.D(:,end);
G.S.pre_fix=G.S.D(:,1:end-1);
G.S.post_fix=G.S.D(:,2:end);

[~,G.S.pre_fix_ind]=ismember(G.S.pre_fix,join_list,'rows');
[~,G.S.post_fix_ind]=ismember(G.S.post_fix,join_list,'rows');
[~,G.S.dock_start_ind]=ismember(G.S.pre_fix,dock_list,'rows');
[~,G.S.dock_end_ind]=ismember(G.S.post_fix,dock_list,'rows');
G.S.starts_soma=F.starts_soma;%=D(:,1);
G.C.start_cost=F.start_cost;%=D(:,2);
G.C.start_cost(G.S.dock_start_ind<0.5)=inf;%F.start_cost;%=D(:,2);
G.C.term_cost=F.term_cost;%=D(:,3);
G.C.cost=F.cost;

G.N=max(max(F.dets));
G.NS=size(G.S.D,1);
G.ND=size(G.dock_list,1);
G.NJ=size(G.join_list,1);
G.LS=size(G.S.D,2);
