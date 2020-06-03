function value = HornerEval(lambdas, x_i, x)

% p(x) = L0 + (x-x0)[L1 + (x-1){L2 + ...}]

% evaluating according to horners scheme
% loops from the inside to the outside

value = lambdas(end);

for i=length(lambdas):-1:1
    value = lambdas(i) + (x - x_i(i)) * value; 
end
