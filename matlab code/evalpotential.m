function y = evalpotential(observation_position,neuron_data)
% neuron_data is a (N+1)*M matrix s.t first raw standing for charge and 
% 2:(N+1) raws stand for N dimentional position. M is the number of
% neurons.
% observation_position is a N*K matrix.
% N = dimention, M = number of neurons, K = number of electrods (observation)
% app is approximation of inverse function.

K = size(observation_position,2);
M = size(neuron_data,2);
y = zeros(1,K);
for i = 1:K
y(i) = sum(neuron_data(1,:)./(sum((observation_position(:,i)*ones(1,M)-neuron_data(2:end,:)).^2,1).^.5));
end
