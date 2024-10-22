function H=call_basic_ilp_solve(G)

T=G.ILP;
T.inds_bin=[1:numel(T.C)];
time_solve=tic();

[sol,obj,flag]=intlinprog(T.C,T.inds_bin,T.A,T.B,T.Aeq,T.Beq,T.LB,T.UB,T.opts);
time_solve=toc(time_solve);
save('moon')
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
H.G=G;

num_splits_GT=sum(G.GT.n_kid>1.5);
H.GT_obj=sum(G.GT.sol_vec.*G.ILP.C(1:G.B.NE))+(G.params.split_cost*num_splits_GT);

%jy_out_sz('G.GT.full_sol',G.GT.full_sol)
%jy_out_sz('G.ILP.C',G.ILP.C)
H.GT_obj2=sum(G.GT.full_sol(:).*G.ILP.C_orig(:));
slacks_GT=-G.ILP.A_orig*G.GT.full_sol+G.ILP.B;
if(min(slacks_GT)<-.000001)
    
   s0=-G.ILP.A0*G.GT.full_sol+G.ILP.B0;
   s1=-G.ILP.A1*G.GT.full_sol+G.ILP.B1;
   s2=-G.ILP.A2*G.GT.full_sol+G.ILP.B2;
   s3=-G.ILP.A3*G.GT.full_sol+G.ILP.B3;
   jy_out_val('sum(G.GT.full_sol.*G.ILP.C)',sum(G.GT.full_sol.*G.ILP.C))
       save('gtIssue')
   jy_out_val('min(s0)',min(s0))
   jy_out_val('min(s1)',min(s1))
   jy_out_val('min(s2)',min(s2))
   jy_out_val('min(s3)',min(s3))
    
   disp('isssue here')
   pause
end

if(H.GT_obj<obj || abs(H.GT_obj2-H.GT_obj)>.00001)
    disp('GT cant be better than optimal')
    jy_out_val('H.GT_obj2')
    jy_out_val('H.GT_obj')
    save('badHere')
    pause
end
%jy_out_val('H.GT_obj',H.GT_obj)
%jy_out_val('H.GT_obj',H.GT_obj)