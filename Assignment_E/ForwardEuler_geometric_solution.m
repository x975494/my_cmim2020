a = 0; b = 3;   % b set for a) 1 for b) 2 for c) 3
dudt = @(u) u;
u_exact = @(t) exp(t);

u = zeros(b+1, 1);
u(1) = 1;
dt = 1;
d = b/dt;
for i = 1:d
    u(i+1) = u(i) + dt*dudt(u(i));
end

tP = linspace(a, b, d+1);
time = linspace(a, b, 100);
u_true = u_exact(time);
plot(time, u_true, 'b-', tP, u, 'ro');
xlabel('t');
ylabel('u(t)');