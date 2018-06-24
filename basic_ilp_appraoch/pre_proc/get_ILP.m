function G=get_ILP(G)

ILP=[];

ILP.C=[G.B.theta(:)+G.opt.edge_offset,split_cost*ones(G.sp.ns,1)];

%number of parents that you have is bounded by 1

v1=G.B.EI(:,2);
v2=G.B.EI(:,1);
v3=ones(G.B.NE,1);
A1=sparse(v1,v2,v3,G.B.N,G.B.NE+G.B.N);
B1=ones(G.B.N,1,1);
%the number of children you can have is upper bounded by
    %bound 1
    %number of parents (or 1 if you dont have any possible)
    %plus 1 if you are a split node

v1=G.B.EI(:,1);
v2=G.B.EI(:,2);
v3=ones(G.B.NE,1);
A2_a=sparse(v1,v2,v3,G.B.N,G.B.NE);
A2_b=-speye(G.B.N,G.B.N);
A2=[A2_a,A2_b]-A1;
v1=G.sp.split_list;
v2=v1*0;
v3=(v1*0)+1;
B2=sparse(v1,v2,v3,G.B.N,1);

    %bound 2
    %2 times the number of parents (1 if u dont have any possible)

    %  number of parents you can have is bounded by 1
v1=G.B.EI(:,1);
v2=G.B.EI(:,2);
v3=ones(G.B.NE,1);
A3_a=sparse(v1,v2,v3,G.B.N,G.B.NE+G.B.N);
A3_b=-A1*2;

B3=2*B2;

    
A=[A1;A2;A3];
A=A(:,[ [1:G.B.NE],G.sp.split_list(:)' ]);
ILP.A=A;
ILP.B=[B1;B2;B3];
    
ILP.Aeq=[];
ILP.Beq=[];

ILP.UB=(ILP.C*0)+1;
ILP.LB=(ILP.C*0);

ILP.opts=optimoptions('display','off');