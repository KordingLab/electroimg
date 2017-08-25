function [dual_sol,lp_val]=solve_master(G,T)


%T.X No more than any subtrack

%tracks are frist var set
%docks
n_cols=numel(T.Theta);
A1=[T.X,zeros(G.N,G.N_dock)];
B1=ones(G.N,1);
A2=[T.sub_start-T.sub_stop,zeros(G.N_dock,G.N_dock)];
A2(A2<-0.5)=-2;
B2=zeros(G.N_dock,1);

A3=[T.sub_start,-speye(G.N_dock,G.N_dock)];
B3=ones(G.N_dock,1);

A4=[zeros(G.N_dock,n_cols),speye(G.N_dock,G.N_dock)];
B4=ones(G.N_dock,1);

A=[A1;A2;A3;A4];
B=[B1;B2;B3;B4];

C=[T.Theta;G.branch_cost];%G.branch_cost*ones(G.N_dock)];

[~,lp_val,~,~,dual_terms]=linprog(C,A,B,[],[],0*C,2+0*C);
dual_sol=[];
dual_sol.L1=dual_terms(1:G.N);
dual_sol.L2=dual_terms(1+G.N:G.N+G.N_doc);
dual_sol.L3=dual_terms(1+G.N+G.N_doc:end);

