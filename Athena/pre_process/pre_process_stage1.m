function G=pre_process_stage1(F,params)

%portion docks make
G=[];
G.F=F;
G.S=[];
G.C=[];

join_list=unique([F.dets(:,1:end-1);F.dets(:,2:end)],'rows');

dock_list=join_list(randperm(size(join_list,1)));
n_keep=params.por_dock*size(join_list,1);
dock_list=dock_list(1:n_keep,:);
dock_list=unique([dock_list;join_list(1)],'rows');
G
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
%G.S.starts_soma=%F.starts_soma;%=D(:,1);
G.S.starts_soma=(G.S.D(:,1)<1.1);%=D(:,1);

G.C.start_cost=F.start_cost;%start cost 
G.C.start_cost(G.S.dock_start_ind<0.5)=inf;%infinite start cost at non-docks
G.C.term_cost=F.term_cost;%cost to terminate a track
G.C.cost=F.cost+params.offset_subtracks_cost;%final cost

G.N=max(max(F.dets));%number of detections 
G.NS=size(G.S.D,1);%number of Subtracks
G.ND=size(G.dock_list,1);%number of docks
G.NJ=size(G.join_list,1);%number of join poits
G.LS=size(G.S.D,2);%length of subtracks
