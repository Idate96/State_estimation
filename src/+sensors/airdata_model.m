function airdata = airdata_model(data, sensor_noise)
    num_samples = size(data.t);
    airdata.V_measured = data.vtas + normrnd(sensor_noise.V_mean, sensor_noise.V_std, num_samples);
    airdata.alpha_measured = data.alpha + normrnd(sensor_noise.alpha_mean, ...
                             sensor_noise.alpha_std, num_samples);
    airdata.beta_measured = data.beta + normrnd(sensor_noise.beta_mean,...
                            sensor_noise.beta_std, num_samples);
end
