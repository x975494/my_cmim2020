function osc_ode_FE()

    % Set and compute problem dependent parameters
    omega = 2;   
    X_0 = 1;
    number_of_periods = 6;
    time_intervals_per_period = 20;
    
    f=@(t, u) [u(2); -omega^2*u(1)];
    
    P = 2*pi/omega;                     % Length of one period
    dt = P/time_intervals_per_period;   % Time step       
    T = number_of_periods*P;            % Final simulation time
    U_0 = [X_0 0];                      % Initial conditions
       
    % Produce u data on file that will be used for reference
    file_name = 'osc_FE_data';
    osc_FE_2file(file_name, X_0, omega, dt, T);    
    tspan = [dt T];
    [t ,w] = ode_FE(f, tspan, U_0);
    u = w(:,1);
    v = w(:,2);
    fprintf('dudt: %g , dvdt: %g\n', v, -omega^2*u);   
    % Read data from file for comparison     
    infile = fopen(file_name, 'r');
    u_ref = fscanf(infile, '%f');
    fclose(infile);
        
    tol = 1E-5;               % Tried several stricter ones first
    for n = 1:length(u)
        err = abs(u_ref(n) - u(n));
        assert(err < tol, 'n=%d, err=%g', n, err);
    end
    
   
    plot(t, u_ref, 'b-', t, u, 'r--');
    legend('u ref', 'u');
end

function osc_FE_2file(filename, X_0, omega, dt, T)
    N_t = floor(T/dt);
    u = zeros(N_t+1, 1);
    v = zeros(N_t+1, 1);

    % Initial condition
    u(1) = X_0;
    v(1) = 0;
    
    outfile = fopen(filename, 'w');
    fprintf(outfile,'%10.5f\n', u(1));

    % Step equations forward in time
    for n = 1:N_t
        u(n+1) = u(n) + dt*v(n);
        v(n+1) = v(n) - dt*omega^2*u(n);
        fprintf(outfile,'%10.5f\n', u(n+1));
    end
    fclose(outfile);  
end