function SIR_dt()
    % Find appropriate time step for an SIR model
   
    beta = 10/(40*8*24);
    gamma = 3/(15*24);        

    f = @(t, u) [-beta*u(1)*u(2); beta*u(1)*u(2) - gamma*u(2); gamma*u(2)];
    
    dt = 48.0;   % 48 h
    D = 30;      % Simulate for D days
    N_t = floor(D*24/dt);    % Corresponding no of hours
    T = dt*N_t;              % End time
    U_0 = [50 1 0];
    tspan = [dt T];
    
    [t_old, u_old] = ode_FE(f, tspan, U_0);
    
    S_old = u_old(:,1);
    I_old = u_old(:,2);
    R_old = u_old(:,3);
    k = 1;
    one_more = true
    while one_more == true
        dt_k = 2^(-k)*dt;
        [t_new, u_new] = ode_FE(f, tspan, U_0);
        S_new = u_new(:,1);
        I_new = u_new(:,2);
        R_new = u_new(:,3);

        plot(t_old, S_old, 'b-', t_new, S_new, 'b--',...
             t_old, I_old, 'r-', t_new, I_new, 'r--',...
             t_old, R_old, 'g-', t_new, R_new, 'g--');
        xlabel('hours'); 
        ylabel('S (blue), I (red), R (green)');
        fprintf('Finest timestep was: %g\n', dt_k);
        answer = input('Do one more with finer dt (y/n)? ','s');
        if strcmp(answer, 'y')
            S_old = S_new;
            R_old = R_new;
            I_old = I_new;
            t_old = t_new;
            k = k + 1;
        else
            one_more = false;
        end
    end
end