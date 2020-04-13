
% u = [theta; d];
a = 0.1;    % m
b = 0.2;    % m
w = -1;      % rad/s
c = 3;      % cycle move
tn = abs(floor(2*pi/w*c));     % s
dt = 0.1;   % s
eps = 1e-4;
t = 0 : dt : tn;
n = length(t);
% set starting point
u0 = [0; b + a];

u = zeros(2,n);

hold on
    for ii = 1 : n
    
    phi = pi/6+w*t(ii);
    F = @(u) constraint(u, a, b, phi);
    J = @(u) jacobian(u, b);

    up = NR_method(F, J, u0, eps);

    u0 = up;
    u(:,ii) = up;
    
    end

subplot(2,1,1)
hold on
plot(t,u(1,:),'r-')
plot(t,u(2,:),'b-')    
title('Move plot')
xlabel('t [s]')
grid on
legend('$\theta$','$d$','interpreter','latex')
hold off

v = zeros(2,n);
phi_v = pi/6+w*t;
v(1,:) = (a*cos(phi_v)*w)./(0.2*cos(u(1,:)));
v(2,:) = -a*sin(phi_v)*w-b*sin(u(1,:)).*v(1,:);

subplot(2,1,2)
hold on
plot(t,v(1,:),'r-')
plot(t,v(2,:),'b-')    
title('Velocity plot')
xlabel('t [s]')
grid on
hold off


function P = constraint(u, a, b, phi)

P = [a * cos(phi) + b * cos(u(1)) - u(2)
    a * sin(phi) - b * sin(u(1))];
end

function P = jacobian(u, b)

P = [-b * sin(u(1)), -1
    -b * cos(u(1)), 0];
end