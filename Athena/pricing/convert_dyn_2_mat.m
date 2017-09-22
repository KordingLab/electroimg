function [T_new,resid,reduced_cost_guess]=convert_dyn_2_mat(G,Z,dual_sol)

if(max(Z.cost)>=0)
    jy_out_val('max(Z.cost)',max(Z.cost))
    disp('flag me no good')
    pause
end
resid=sum(Z.cost);
T_new=[];

T_new.sub=con_sub(G,Z);
T_new.X=con_x(G,Z);
T_new.non_start=con_non_start(G,Z);

T_new.Theta=con_Theta(G,Z);
T_new.dock_in=con_dock_in(G,Z);
T_new.dock_out=con_dock_out(G,Z);

%jy_out_val('T_new.dock_in(1)',T_new.dock_in(1))
%jy_out_val('T_new.dock_out(1)',T_new.dock_out(1))
%jy_out_val('Z.cost(1)',Z.cost(1))
%pause;
%jy_out_sz('T_new.X',T_new.X)
%jy_out_sz('dual_sol.lambda_1',dual_sol.lambda_1)
det_term=T_new.X'*dual_sol.lambda_1;
start_term=0.5*T_new.dock_in'*dual_sol.lambda_2;
end_term=-T_new.dock_out'*dual_sol.lambda_2;
reduced_cost_guess=T_new.Theta+det_term+start_term+end_term;
my_gap=abs(Z.cost-reduced_cost_guess);
[max_gap,max_gap_ind]=max(my_gap);
if(.0001< max_gap  )
    disp('problem here')
    jy_out_val('max_gap',max_gap)
    jy_out_val('max_gap_ind',max_gap_ind)
    jy_out_val('reduced_cost_guess(max_gap_ind)',reduced_cost_guess(max_gap_ind))
    pause
else
    
    disp('no gaps found')
    jy_out_val('max_gap',max_gap)

    
    
end