function osc_FE_func()
    omega = 2;
    P = 2*pi/omega;
    dt = P/20;
    T = 3*P;
    X_0 = 2;
    [u, v, t] = osc_FE(X_0, omega, dt, T);

    plot(t, u, 'b-', t, X_0*cos(omega*t), 'r--');
    xlabel('t');
end