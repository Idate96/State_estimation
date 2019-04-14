function states_dot = state_func(t, states, inputs)
    % main states used in the dynamics
    u = states(4); v = states(5); w = states(6);
    phi = states(7); theta = states(8); psi_ = states(9);
    Ax_bias = states(10); Ay_bias = states(11); Az_bias = states(12);
    p_bias = states(13); q_bias = states(14); r_bias = states(15);
    wind_x = states(16); wind_y = states(17); wind_z = states(18);
    
    % inputs
    Ax = inputs(1); Ay = inputs(2); Az = inputs(3);
    p = inputs(4); q = inputs(5); r = inputs(6);
    
    g = 9.81;
    x_dot = (u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* cos(psi_) + ...
        - (v .* cos(phi) - w .* sin(phi)) .* sin(psi_) + wind_x;
    y_dot = (u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* sin(psi_) + ...
        + (v .* cos(phi) - w .* sin(phi)) .* cos(psi_) + wind_y;
    z_dot = - u .* sin(theta)  + (v .* sin(phi) + w .* cos(phi)) .* cos(theta) + wind_z;
    u_dot = (Ax - Ax_bias) - g .* sin(theta) + (r - r_bias) .* v - (q - q_bias) .* w;
    v_dot = (Ay - Ay_bias) + g .* cos(theta) .* sin(phi) + (p - p_bias) .* w - (r - r_bias) .* u;
    w_dot = (Az - Az_bias) + g .* cos(theta) .* cos(phi) + (q - q_bias) .* u - (p - p_bias) .* v;
    phi_dot = (p - p_bias) + (q - q_bias) .* sin(phi) .* tan(theta) + (r - r_bias) .* cos(phi) .* tan(theta);
    theta_dot = (q - q_bias) .* cos(phi) - (r - r_bias) .* sin(phi);
    psi_dot = (q - q_bias) .* sin(phi) ./ cos(theta) + (r - r_bias) .* cos(phi) ./ cos(theta);
    Ax_bias_dot = 0;
    Ay_bias_dot = 0;
    Az_bias_dot = 0;
    p_bias_dot = 0;
    q_bias_dot = 0;
    r_bias_dot = 0;
    wind_x_dot = 0;
    wind_y_dot = 0;
    wind_z_dot = 0;
    
    
    states_dot = [x_dot; y_dot; z_dot; u_dot; v_dot; w_dot; phi_dot;
                    theta_dot; psi_dot; Ax_bias_dot; Ay_bias_dot; Az_bias_dot;
                    p_bias_dot; q_bias_dot; r_bias_dot; wind_x_dot; wind_y_dot; wind_z_dot];
    
end 