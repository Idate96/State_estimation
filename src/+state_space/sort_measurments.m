function [output, state, input] = sort_measurments(data)
% output_variables x, y, z, x_dot, y_dot, z_dot, phi, theta, psi, V, alpha,
% beta

    output = [data.x, data.y, data.z, data.x_dot, data.y_dot, data.z_dot, ...
              data.phi, data.theta, data.psi, data.vtas, data.alpha, data.beta]';
          
    % incomplete state space
    state = [data.x, data.y, data.z, data.u_n, data.v_n, data.w_n, ...
            data.phi, data.theta, data.psi]';
    % input vars Ax Ay Az p q r
    input = [data.Ax, data.Ay, data.Az, data.p, data.q, data.r]';
end