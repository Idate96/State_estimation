function gps_data = gps_model(data, sensor_noise, system_noise)
    num_samples = size(data.t);
    gps_data.x_measured = data.x + normrnd(sensor_noise.x_mean, sensor_noise.x_std, num_samples);
    gps_data.y_measured = data.y + normrnd(sensor_noise.y_mean, sensor_noise.y_std, num_samples);
    gps_data.z_measured = data.z + normrnd(sensor_noise.z_mean, sensor_noise.z_std, num_samples);
    
    gps_data.x_dot_measured = data.x_dot + normrnd(sensor_noise.x_dot_mean, ...
                              sensor_noise.x_dot_std, num_samples) + system_noise.x_dot_mean;
    gps_data.y_dot_measured = data.y_dot + normrnd(sensor_noise.y_dot_mean, ...
                              sensor_noise.y_dot_std, num_samples) + system_noise.y_dot_mean;
    gps_data.z_dot_measured = data.z_dot + normrnd(sensor_noise.z_dot_mean, ...
                              sensor_noise.z_dot_std, num_samples) + system_noise.z_dot_mean;
                          
    gps_data.phi_measured = data.phi + normrnd(sensor_noise.phi_mean, ...
                            sensor_noise.phi_std, num_samples);
    gps_data.theta_measured = data.theta + normrnd(sensor_noise.theta_mean, ...
                            sensor_noise.theta_std, num_samples);
    gps_data.psi_measured = data.psi + normrnd(sensor_noise.psi_mean, ...
                            sensor_noise.psi_std, num_samples);
end