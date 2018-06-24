function G=get_ILP(G)

ILP=[];

ILP.C=[G.B.theta(:)+G.opt.edge_offset,split_cost*ones(G.sp.ns,1)];

%the number of children you can have is upper bounded by
    %bound 1
    %number of parents (or 1 if you dont have any possible)
    %plus 1 if you are a split node

    %bound 2
    %2 times the number of parents (1 if u dont have any possible)

    %  number of parents you can have is bounded by 1
ILP.Aeq=[];
ILP.Beq=[];

ILP.UB=(ILP.C*0)+1;
ILP.LB=(ILP.C*0);

ILP.opts=optimoptions('display','off');