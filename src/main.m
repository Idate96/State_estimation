function main()
    % some unclear variables names
    % A = acceleration
    % da = deflection aileron
    % de = deflection elevator
    % dr = delfection rudder
    % dta = deflection trim aileron
    aircraft_properties = struct();
    aircraft_properties.I_xx = 11187.8; % kg m^2
    aircraft_properties.I_yy = 22854.8;
    aircraft_properties.I_zz = 31974.8;
    aircraft_properties.I_xz = 1930.1;
    aircraft_properties.mass = 4500; % kg
    aircraft_properties.wing_span = 13.3250; % m 
    aircraft_properties.wing_area = 24.99; % m^2
    aircraft_properties.chord = 1.991; % m
    
    data_aileron_3211 = load('simdata2019/da3211');
    data_aileron_doublet = load('simdata2019/dadoublet');
    data_elevator_3211 = load('simdata2019/de3211');
    data_rudder_3211 = load('simdata2019/dr3211');
    data_rudder_doublet = load('simdata2019/drdoublet');
    
    wind = struct();
    wind.x = 10; % wind m\s
    wind.y = 6;
    wind.z = 1;
    
    [Q, R, ~] = sensors.noise_covariance();
    data_aileron_3211 = state_space.estimate_pos(data_aileron_3211, wind);
    
    [output_meas, state_meas, input_meas] = state_space.sort_measurments(data_aileron_3211);

    x_opt_0 = [state_meas(:, 1); 0; 0; 0; 0; 0; 0; 1; 1; 1];
    P_0 = eye(18);
    test_sample = 25;
    
    x_estimated = iter_ext_kalman_filter(output_meas(:, 1:test_sample), input_meas(:, 1:test_sample), ...
                                    x_opt_0, P_0, Q, R, data_aileron_3211.t(1:test_sample));
                                
    plot(data_aileron_3211.t(1:test_sample), x_estimated(1, 1:test_sample), ...
        data_aileron_3211.t(1:test_sample), state_meas(1, 1:test_sample))
end