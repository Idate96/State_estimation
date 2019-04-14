function preprocessed_data = estimate_pos(data, wind)
    % add new references to ease reading
    u = data.u_n;
    v = data.v_n;
    w = data.w_n;
    phi = data.phi;
    psi = data.psi;
    theta = data.theta;
    
    % compute positions and velocities in inertial frame
    x_dot = (u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* cos(psi) + ...
        - (v .* cos(phi) - w .* sin(phi)) .* sin(psi) + wind.x;
    y_dot = (u .* cos(theta) + (v .* sin(phi) + w .* cos(phi)).*sin(theta)) .* sin(psi) + ...
        + (v .* cos(phi) - w .* sin(phi)) .* cos(psi) + wind.y;
    z_dot = - u .* sin(theta)  + (v .* sin(phi) + w .* cos(phi)) .* cos(theta) + wind.z;
    x = cumtrapz(data.t, x_dot);
    y = cumtrapz(data.t, y_dot);
    z = cumtrapz(data.t, z_dot); 
    
    preprocessed_data = data;
    preprocessed_data.x_dot = x_dot;
    preprocessed_data.x = x;
    preprocessed_data.y_dot = y_dot;
    preprocessed_data.y = y;
    preprocessed_data.z_dot = z_dot;
    preprocessed_data.z = z;
end