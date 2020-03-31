
% u = [theta; d];
a = 0.1;    % m
b = 0.2;    % m
w = 1;      % rad/s
tn = floor(2*pi/w);     % s
dt = 0.1;   % s
eps = 1e-4;
% set starting point
u0 = [0; b + a];


hold on
    for t = 1 : dt: tn
    
    phi = pi/6+w*t;
    F = @(u) constraint(u, a, b, phi);
    J = @(u) jacobian(u, a);

    
    [u, iteration_counter] = NR_method(F, J, u0, eps);

    plot(t, rad2deg(u(1)), t, u(2))
    
    u0 = u;
    end
    
title('Move plot')
xlabel('t [s]')

function P = constraint(u, a, b, phi)
theta = u(1);
d = u(2);

P = [a * cos(phi) + b * cos(theta) - d
    a * sin(phi) - b * sin(theta)];
end

function P = jacobian(u, b)
theta = u(1);
P = [-b * sin(theta), -1
    -b * cos(theta), 0];
end