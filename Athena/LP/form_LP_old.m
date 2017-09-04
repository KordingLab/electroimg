function [C,A,B]=form_LP(G,T)

n_track=size(T.non_start,2);
%T.non_start*\gamma <=1
A1a=T.non_start_det;
A1b=sparse([],[],[],G.N,G.n_term);
A1=[A1a,A1b];
B1=ones(G.N,1);

%0.5 T.end_doc \gamma<=T.start_doc \gamma

A2a=-T.end_doc_mat+0.5*T.start_doc_mat;
A2b=sparse([],[],[],G.n_term,G.n_term);
A2=[A2a,Ab];
B2=zeros(G.n_term,1);
%\leq T.start_doc \gamma +facility_term

A3a=T.start_doc_mat;
A3b=-speye(G.n_term,G.n_term);
B3=ones(G.n_term,1);

A=[A1;A2;A3];function [C,A,B]=form_LP(G,T)

n_track=size(T.non_start,2);
%T.non_start*\gamma <=1
A1a=T.non_start_det;
A1b=sparse([],[],[],G.N,G.n_term);
A1=[A1a,A1b];
B1=ones(G.N,1);

%0.5 T.end_doc \gamma<=T.start_doc \gamma

A2a=-T.end_doc_mat+0.5*T.start_doc_mat;
A2b=sparse([],[],[],G.n_term,G.n_term);
A2=[A2a,Ab];
B2=zeros(G.n_term,1);
%\leq T.start_doc \gamma +facility_term

A3a=T.start_doc_mat;
A3b=-speye(G.n_term,G.n_term);
B3=ones(G.n_term,1);

A=[A1;A2;A3];