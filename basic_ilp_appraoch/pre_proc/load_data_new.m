function F=load_data(my_input_file)

load(my_input_file);

%store original data
F=[];
F.x=xx;
F.y=yy;
F.z=xx*0;
F.time=tt;
F.bar_E=W*0;

%if(max(sum(E,2))>3.5 || max(sum(E,1))>3.5 )
%    disp('too many kids parents')
%    jy_out_val('max(sum(E,2))',max(sum(E,2)))
%    jy_out_val('max(sum(E,1))',max(sum(E,1)))
%    pause
%end
	
F.W=W;

F.W=F.W(2:end,2:end);
F.x=F.x(2:end,:);
F.y=F.y(2:end,:);
F.z=F.z(2:end,:);
F.time=F.time(2:end,:);
F.bar_E=F.bar_E(2:end,2:end);

