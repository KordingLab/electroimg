function [C,A,B]=form_LP(G,T)

%T.non_start*\gamma <=1
A1=T.non_start_det;
A1=[A1a,A1b];
B1=ones(G.N,1);


A2=-T.end_doc_mat+0.5*T.start_doc_mat;
B2=zeros(G.n_term,1);

A=[A1;A2];
B=[B1;B2];

C=T.Theta;