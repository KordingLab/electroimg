function F=read_data(in_name)

tmp=load('in_name');
D=tmp.subtracks;
%subtracks is in data 
[~,my_order]=sortrows(D(:,5:end));
D=D(my_order,:);
F=[];
F.data=D;
F.starts_soma=D(:,1);
F.start_cost=D(:,2);
F.term_cost=D(:,3);
F.cost=D(:,4);
F.dets=D(:,5:end);
