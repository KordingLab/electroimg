function [C,A,B]=form_LP(G,T)

A1b=zeros()
A1=[A1a,A1b];
B1=ones(G.N,1);
