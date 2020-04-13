% Hands on solution for Simple Mechanism task

% u = [theta; d];
a = 0.1;
b = 0.2;
phi = deg2rad(30);

% set starting point
u0 = [0; b + a];

F = @(u) constraint(u, a, b, phi);
J = @(u) jacobian(u, b);

eps = 1e-4;
u = NR_method(F, J, u0, eps);

fprintf('\n\tMechanism valid position is for d = %gm and phi1 = %gdeg\n\n', ...
    u(2), rad2deg(u(1)));

function P = constraint(u, a, b, phi)

P = [a * cos(phi) + b * cos(u(1)) - u(2)
    a * sin(phi) - b * sin(u(1))];
end

function P = jacobian(u, b)
theta = u(1);
P = [-b * sin(theta), -1
    -b * cos(theta), 0];
end