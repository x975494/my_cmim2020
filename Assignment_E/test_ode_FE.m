function test_ode_FE()
    test_ode_FE1();    % a)
    test_ode_FE2();    % b)
end
%%
function test_ode_FE1() % a)

f = @(t, u) u;
    hand = [1 2 4 8];
    T = 3;
    dt = 1;
    U_0 = 1.0;
    tspan = [dt T];
    [t, u] = ode_FE(f, tspan, U_0);
    tol = 1E-10;
    for i = 1:length(hand)
        err = abs(hand(i) - u(i));
        assert(err < tol, 'i=%d, err=%g', i, err);
    end
end
%%        
function test_ode_FE2() % b)
    T = 3;
    dt = 0.1;       % if one OK test secound mor concrete
    U_0 = 1.0; 
    tspan = [dt T];
    r = 1;
    f = @(t, u) u*r;
    function result = u_exact(U_0, dt, n)
        r = 1;
        result = U_0*(1+r*dt)^n;
    end
    [t, u] = ode_FE(f, tspan, U_0);
    tol = 1E-12;     
    for n = 1:length(u)
        err = abs(u_exact(U_0, dt, n-1) - u(n));
        assert(err < tol, 'n=%d, err=%g', n, err);
    end
end
