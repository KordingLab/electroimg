function H=call_basic_ilp_solve(G)

G
T=G.ILP;
time_solve=tic();
[sol,obj,flag]=intlinprog(T.C,T.inds_bin,T.A,T.B,T.Aeq,T.Beq,T.LB,T.UB,T.opts);
time_solve=toc(time_solve);
if(flag <0.5)
    flag
    save('tata')
    disp('prob HERE')
    pause
end

H=[];
H.sol=sol;
H.obj=obj;
H.flag=flag;
H.time_solve=time_solve;
H.Ebar=sol2desc(G,H.sol(1:G.B.NE));
%sparse(G.B.EI_conv(:,1),G.B.EI_conv(:,2),H.sol(1:G.B.NE),G.B.N,G.B.N);


