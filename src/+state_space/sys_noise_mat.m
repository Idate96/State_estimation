function system_noise_mat = sys_noise_mat(states)
    u = states(4); v = states(5); w = states(6);
    phi = states(7); theta = states(8);
    
    system_noise_mat = zeros(18, 6);
    system_noise_mat(4, :) = [-1, 0, 0, 0, -v, w];
    system_noise_mat(5, :) = [-1, 0, 0, -w, 0, u];
    system_noise_mat(6, :) = [-1, 0, 0, 0, -u, v];
    system_noise_mat(7, :) = [0, 0, 0, -1, - sin(phi) .* tan(theta), -cos(phi) .* tan(theta)];
    system_noise_mat(8, :) = [0, 0, 0, 0, -cos(phi), sin(phi)];
    system_noise_mat(9, :) = [0, 0, 0, 0, sin(phi) ./ cos(theta), cos(phi) ./ cos(theta)];
end