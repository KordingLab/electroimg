for po = 1:5
    
plot(Sample,P(1,:,po))
hold on
end
legend('25','30','35','40','45')%,'50')
%%
po = 5;
    
plot(Sample,P(1,:,po))
%%
scatter3(Electrod_positions(1,:),Electrod_positions(2,:),Electrod_positions(3,:))
%hold on
% for i = 1:
% scatter3(P(3,:),P(4,:),P(5,:))
% scatter3(P(7,:),P(8,:),P(9,:))
%%
scatter3(P(3,:,po),P(4,:,po),P(5,:,po),'*')
hold on
scatter3(P(7,:,po),P(8,:,po),P(9,:,po),'*')
scatter3(Neuron_positions(2,1),Neuron_positions(3,1),Neuron_positions(4,1),'.')
scatter3(Neuron_positions(2,2),Neuron_positions(3,2),Neuron_positions(4,2),'.')
