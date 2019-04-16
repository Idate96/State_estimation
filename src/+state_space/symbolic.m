function [system, state_vars, input_vars] = generate_state_space()
    % state variables
    syms x y z u v w phi theta psi_ Ax_bias Ay_bias Az_bias p_bias q_bias r_bias wind_x wind_y wind_z
    % input variables
    syms Ax Ay Az p q r
    
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
    
    system.state_func = [x_dot; y_dot; z_dot; u_dot; v_dot; w_dot; phi_dot; theta_dot; psi_dot; ...
            Ax_bias_dot; Ay_bias_dot; Az_bias_dot; p_bias_dot; q_bias_dot; r_bias_dot; ...
            wind_x_dot; wind_y_dot; wind_z_dot;];
        
    % system noise vars : samples from ~ normal(0, sensor_noise.var_std)
    % same order as input variables
    system_noise_eq = sym(zeros(18, 6));
    system_noise_eq(4, :) = [-1, 0, 0, 0, w, -v];
    system_noise_eq(5, :) = [0, -1, 0, -w, 0, u];
    system_noise_eq(6, :) = [0, 0, -1, v, -u, 0];
    system_noise_eq(7, :) = [0, 0, 0, -1, - sin(phi) .* tan(theta), -cos(phi) .* tan(theta)];
    system_noise_eq(8, :) = [0, 0, 0, 0, -cos(phi), sin(phi)];
    system_noise_eq(9, :) = [0, 0, 0, 0, -sin(phi) ./ cos(theta), -cos(phi) ./ cos(theta)];
    system.system_noise_eq = system_noise_eq;
    
    % output function 
    x_gps = x;
    y_gps = y;
    z_gps = z;
    x_dot_gps = (u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* cos(psi_) + ...
        - (v .* cos(phi) - w .* sin(phi)) .* sin(psi_) + wind_x;
    y_dot_gps =(u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* sin(psi_) + ...
        + (v .* cos(phi) - w .* sin(phi)) .* cos(psi_) + wind_y;
    z_dot_gps = - u .* sin(theta)  + (v .* sin(phi) + w .* cos(phi)) .* cos(theta)+wind_z;
    phi_gps = phi;
    theta_gps = theta;
    psi_gps = psi_;
    V_out = (u.^2 + v.^2 + w.^2).^(0.5);
    alpha_out = atan(w./u);
    beta_out = atan(v./(u.^2 + w.^2).^(0.5));
    system.output_func = [x_gps; y_gps; z_gps; x_dot_gps; y_dot_gps; z_dot_gps; ...
                    phi_gps; theta_gps; psi_gps; V_out; alpha_out; beta_out;];
                
    system.sensor_noise_eq = diag(ones(12, 1));
    
    state_vars = [x; y; z; u; v; w; phi; theta; psi_; Ax_bias; ...
           Ay_bias; Az_bias; p_bias; q_bias; r_bias; wind_x; wind_y; wind_z];
    
    input_vars = [Ax; Ay; Az; p; q; r];
end
