function x_estimate = iter_ext_kalman_filter(z, u, x_opt_0, P_0, Q, R, time)
    num_states = length(x_opt_0);
    num_samples = length(z(1, :));
    % x_k1k1 = x_{k-1, k-1}
    x_k1k1 = x_opt_0;
    P_k1k1 = P_0;
    % symbolic system
    [system, state_vars, input_vars] = state_space.symbolic();
    [state_func_grad_sym, output_func_grad_sym] = state_space.find_jacobian(system, state_vars);
    x_estimate = zeros(num_states, num_samples);
    calculate_nonlin_obs_rank(system.state_func, system.output_func, state_vars, x_k1k1);

    
    for k = 1:num_samples - 1
        disp(k);
        % 1. prediction of state using model
        [t, x_kk1] = ode45(@(t, x) state_space.state_func(t, x, u(:, k)), [time(k), time(k + 1)], x_k1k1);
        x_kk1 = x_kk1(end, :)';
        z_kk1 = state_space.output_func(x_kk1);
        % 2. linearize by computing gradients
        state_grad = subs(state_func_grad_sym, state_vars, x_kk1);
        state_grad = double(subs(state_grad, input_vars, u(:, k)));
        output_grad = subs(output_func_grad_sym, state_vars, x_kk1);
        output_grad = double(subs(output_grad, input_vars, u(:, k)));
        % 3. discretize
        [state_func_disc, noise_input_mat_disc] = c2d(state_grad, ...
                                        state_space.sys_noise_mat(x_kk1), time(k + 1) - time(k));
                                    
        % 4. predicted covariance
        P_kk1 = state_func_disc * P_k1k1 * state_func_disc'  + ...
                  noise_input_mat_disc * Q * noise_input_mat_disc';
              
        % 5. kalman gain
        S_k = R + output_grad * P_kk1 * output_grad';
        K = P_kk1 * output_grad' / S_k;
        
        % 6. update of estimate with measurment z 
        x_kk = x_kk1 + K * (z(k) - z_kk1);
        
        % 7. update covariance matrix
        P_kk = (eye(num_states) - K * output_grad) * P_kk1 * ...
            (eye(num_states) - K * output_grad)' + K * R * K';
                
        % update staes
        x_k1k1 = x_kk;
        P_k1k1 = P_kk;
            
        % save states
        x_estimate(:, k) = x_kk;
    end 
end
