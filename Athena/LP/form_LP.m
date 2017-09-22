function [C,A,B]=form_LP(G,T)

%T.non_start*\gamma <=1

A1=T.non_start;
B1=ones(G.N,1);


A2=0.5*T.dock_in-T.dock_out;
B2=zeros(G.ND,1);

A=[A1;A2];
B=[B1;B2];

C=T.Theta;