
function [x, iteration_counter] = NR_method(F, J, x, eps)

F_value = F(x);
F_norm = norm(F_value); % L2 norm of vector
iteration_counter = 0;
while F_norm > eps && iteration_counter < 1e+5
    delta = J(x)\-F_value;
    x = x + delta;
    F_value = F(x);
    F_norm = norm(F_value);
    iteration_counter = iteration_counter + 1;
end
    if F_norm > eps
    iteration_counter = -1;
    end
end