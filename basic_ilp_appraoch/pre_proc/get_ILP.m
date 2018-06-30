function G=get_ILP(G)

ILP=[];

ILP.C=[G.B.theta(:)+G.params.edge_offset;G.params.split_cost*ones(G.B.N,1)];

%number of parents that you have is bounded by 1

v1=G.B.EI(:,2);
v2=[1:G.B.NE];%G.B.EI(:,1);
v3=ones(G.B.NE,1);

A1=sparse(v1,v2,v3,G.B.N,G.B.NE+G.B.N);
B1=ones(G.B.N,1,1);
%the number of children you can have is upper bounded by
    %bound 1
    %number of parents (or 1 if you dont have any possible)
    %plus 1 if you are a split node

v1=G.B.EI(:,1);
v2=[1:G.B.NE];%G.B.EI(:,2);
v3=ones(G.B.NE,1);
A2_a=sparse(v1,v2,v3,G.B.N,G.B.NE);
A2_b=-speye(G.B.N,G.B.N);
A2=[A2_a,A2_b]-A1;
v1=G.B.no_par_list;
v2=(v1*0)+1;
v3=(v1*0)+1;
B2=sparse(v1,v2,v3,G.B.N,1);

    %bound 2
    %2 times the number of parents (1 if u dont have any possible)

    %  number of parents you can have is bounded by 1
v1=G.B.EI(:,1);
v2=[1:G.B.NE];%G.B.EI(:,2);
v3=ones(G.B.NE,1);
A3_a=sparse(v1,v2,v3,G.B.N,G.B.NE+G.B.N);
A3_b=-A1*2;
A3=A3_a+A3_b;
B3=2*B2;
A3=A3(2:end,:);
B3=B3(2:end);

A2=A2(2:end,:);
B2=B2(2:end);

v2=G.B.NE+[1:G.B.N];
v1=ones(G.B.N,1);
v3=ones(G.B.N,1);
A0=sparse(v1,v2,v3,1,G.B.NE+G.B.N);

B0=G.params.max_splits;
if(B0<-0.5)
    B0=G.B.N;
end
A=[A0;A1;A2;A3];
ILP.A_orig=A;
inds_keep=[ [1:G.B.NE],G.B.NE+G.sp.split_list(:)' ];
A=A(:,inds_keep);
ILP.inds_keep=inds_keep;
ILP.C_orig=ILP.C;
ILP.C=ILP.C(inds_keep);
ILP.A0=A0;
ILP.A1=A1;
ILP.A2=A2;
ILP.A3=A3;

ILP.B0=B0;
ILP.B1=B1;
ILP.B2=B2;
ILP.B3=B3;


ILP.A=A;
ILP.B=[B0;B1;B2;B3];

ILP.inds_bin=G.B.NE+G.sp.split_list;

ILP.Aeq=[];
ILP.Beq=[];

ILP.UB=(ILP.C*0)+1;
ILP.LB=(ILP.C*0);

ILP.opts=optimoptions('intlinprog','display','off');

G.ILP=ILP;

save('my_ilp_info')


