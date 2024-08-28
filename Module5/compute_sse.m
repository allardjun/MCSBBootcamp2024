function SSE = compute_sse(lambda, theta, alpha, N0, t_exp, N_exp)

    bacterial_growth =@(t, N, lambda, theta, alpha) lambda * N * (1 - (N / theta)^alpha);

    % Solve ODE at experimental time points
    [~, N_sim] = ode45(@(t, N) bacterial_growth(t, N, lambda, theta, alpha), t_exp, N0);
    
    % Compute SSE
    SSE = sum((N_sim - N_exp).^2);
end