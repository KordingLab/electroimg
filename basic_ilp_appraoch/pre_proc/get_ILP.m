function G=get_ILP(G)

ILP=[];

ILP.C=

ILP.Aeq=[];
ILP.Beq=[];

ILP.UB=(ILP.C*0)+1;
ILP.LB=(ILP.C*0);

ILP.opts=optimoptions('display','off');