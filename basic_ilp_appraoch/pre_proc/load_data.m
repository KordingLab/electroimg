function F=load_data(my_input_file)

load(my_input_file);

%store original data
F=[];
F.x=x;
F.y=y;
F.z=z;
F.time=time;
F.bar_E=E;
F.W=W;

