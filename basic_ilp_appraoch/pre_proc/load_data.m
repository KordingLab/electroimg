function F=load_data(my_input_file)

load(my_input_file);

%store original data
F=[];
F.x=x;
F.y=y;
F.z=z;
F.time=time;
F.bar_E=E;

%if(max(sum(E,2))>3.5 || max(sum(E,1))>3.5 )
%    disp('too many kids parents')
%    jy_out_val('max(sum(E,2))',max(sum(E,2)))
%    jy_out_val('max(sum(E,1))',max(sum(E,1)))
%    pause
%end
	
F.W=W;

