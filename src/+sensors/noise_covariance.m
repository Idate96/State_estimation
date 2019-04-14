function [Q, R, sensor_noise] = noise_covariance()
    sensor_noise = struct();
    % imu sensor noise
    sensor_noise.Ax_mean = 0.001;
    sensor_noise.Ax_std = 0.001;
    sensor_noise.Ay_mean = 0.001;
    sensor_noise.Ay_std = 0.001;
    sensor_noise.Az_mean = 0.001;
    sensor_noise.Az_std = 0.001;
    sensor_noise.p_mean = deg2rad(0.001);
    sensor_noise.p_std = deg2rad(0.001);
    sensor_noise.q_mean = deg2rad(0.001);
    sensor_noise.q_std = deg2rad(0.001);
    sensor_noise.r_mean = deg2rad(0.001);
    sensor_noise.r_std = deg2rad(0.001);
    % gps sensor noise
    sensor_noise.x_std = 10; % m 
    sensor_noise.y_std = 10;
    sensor_noise.z_std = 10;
    sensor_noise.x_dot_std = 0.1; % m/s
    sensor_noise.y_dot_std = 0.1; 
    sensor_noise.z_dot_std = 0.1; 
    sensor_noise.theta_std = deg2rad(0.1); % deg
    sensor_noise.phi_std = deg2rad(0.1);
    sensor_noise.psi_std = deg2rad(0.1);
    % airdata noise 
    sensor_noise.V_std = 0.1; % m/s
    sensor_noise.alpha_std = deg2rad(0.1);% deg
    sensor_noise.beta_std = deg2rad(0.1);
    
    % input covariance of noise
    Q = zeros(6, 6);
    Q(1,1) = sensor_noise.Ax_std^2;
    Q(2,2) = sensor_noise.Ay_std^2;
    Q(3,3) = sensor_noise.Az_std^2;
    Q(4,4) = sensor_noise.p_std^2;
    Q(5,5) = sensor_noise.q_std^2;
    Q(6,6) = sensor_noise.r_std^2;
    
    % sensor covariances of outputs
    R = zeros(12, 12);
    R(1, 1) = sensor_noise.x_std^2;
    R(2 ,2) = sensor_noise.y_std^2;
    R(3, 3) = sensor_noise.z_std^2;
    R(4, 4) = sensor_noise.x_dot_std^2;
    R(5, 5) = sensor_noise.y_dot_std^2;
    R(6, 6) = sensor_noise.z_dot_std^2;
    R(7, 7) = sensor_noise.phi_std^2;
    R(8, 8) = sensor_noise.theta_std^2;
    R(9, 9) = sensor_noise.psi_std^2;
    R(10, 10) = sensor_noise.V_std^2;
    R(11, 11) = sensor_noise.alpha_std^2;
    R(12, 12) = sensor_noise.beta_std^2;
end