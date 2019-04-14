function output_sim = output_func(states)
    x = states(1); y = states(2); z = states(3);
    u = states(4); v = states(5); w = states(6);
    phi = states(7); theta = states(8); psi_ = states(9);
    wind_x = states(16); wind_y = states(17); wind_z = states(18);

    % output function 
    x_gps = x;
    y_gps = y;
    z_gps = z;
    x_dot_gps = (u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* cos(psi_) + ...
        - (v .* cos(phi) - w .* sin(phi)) .* sin(psi_) + wind_x;
    y_dot_gps =(u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* sin(psi_) + ...
        + (v .* cos(phi) - w .* sin(phi)) .* cos(psi_) + wind_y;
    z_dot_gps = - u .* sin(theta)  + (v .* sin(phi) + w .* cos(phi)) .* cos(theta) + wind_z;
    phi_gps = phi;
    theta_gps = theta;
    psi_gps = psi_;
    V_out = (u.^2 + v.^2 + w.^2).^(0.5);
    alpha_out = atan(w./u);
    beta_out = atan(v./(u.^2 + w.^2).^(0.5));
    
    output_sim = [x_gps; y_gps; z_gps; x_dot_gps; y_dot_gps; z_dot_gps; ...
                    phi_gps; theta_gps; psi_gps; V_out; alpha_out; beta_out;];
                

end