classdef TestStateSpace < matlab.unittest.TestCase
    %TEST_STATE_SPACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        system
        state_vars
        input_vars
        state_func_grad
        output_func_grad
    end
    methods
        function obj = TestStateSpace()
            [system, state_vars, input_vars] = state_space.symbolic();
            [state_grad, output_grad] = state_space.find_jacobian(system, state_vars);
            obj.system = system;
            obj.state_vars = state_vars;
            obj.input_vars = input_vars;
            obj.state_func_grad = state_grad;
            obj.output_func_grad = output_grad;
        end
    end
    methods (Test)
        function test_state_space_entry(testCase)
            syms Ax theta r v q w Ax_bias q_bias r_bias
            u_dot = Ax - Ax_bias - 981/100 * sin(theta) + (r - r_bias) * v - (q - q_bias) * w;
            u_dot_num = subs(u_dot, [Ax theta r v q w Ax_bias q_bias r_bias], ...
                                [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]);
            u_dot_num_to_test = subs(testCase.system.state_func(4, :), ...
                                [Ax theta r v q w Ax_bias q_bias r_bias], ...
                                [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]);
            testCase.verifyEqual(u_dot_num, u_dot_num_to_test);
        end
        function test_state_gradient(testCase)
            syms theta
            u_dot_grad_theta = -981/100 * cos(theta);
            u_dot_grad_theta_to_test = testCase.state_func_grad(4, 8);
            u_dot_grad_theta_num = subs(u_dot_grad_theta, [theta], [0.1]);
            u_dot_grad_theta_to_test_num = subs(u_dot_grad_theta_to_test, [theta], [0.1]);
            testCase.verifyEqual(u_dot_grad_theta_num, u_dot_grad_theta_to_test_num);
        end
        function test_eq_of_motion(testCase)
            % given the same initial state, measured and simulated vars
            % should be the same
            % 1. prediction of state using model
            data_aileron_3211 = load('simdata2019/da3211');
            time = data_aileron_3211.t;
            wind = struct();
            wind.x = 0; % wind m\s
            wind.y = 0;
            wind.z = 0;
            data_aileron_3211 = state_space.estimate_pos(data_aileron_3211, wind);
            [output_meas, state_meas, input_meas] = state_space.sort_measurments(data_aileron_3211);
            
            output_sim = zeros(size(output_meas));
            num_samples = length(output_meas(1, :));
            state_sim = zeros(18, num_samples);    
            x_k = [state_meas(:, 1); 0; 0; 0; 0; 0; 0; 0; 0; 0];
            state_sim(:, 1) = x_k;         
            output_sim(:, 1) = state_space.output_func(x_k);

            for k = 1:num_samples - 1
                [t, x_k] = ode45(@(t, x) state_space.state_func(t, x, input_meas(:, k)), [time(k), time(k + 1)], x_k);
                x_k = x_k(end, :)';
                z_k = state_space.output_func(x_k);
                state_sim(:, k + 1) = x_k;
                output_sim(:, k + 1) = z_k;
            end
            
            plotting.plot_compare_pos(time, output_sim, output_meas, 'images', 'pos');
            plotting.plot_compare_pos(time, output_sim, output_meas, 'images', 'vel');
            plotting.plot_compare_pos(time, output_sim, output_meas, 'images', 'angle');
            plotting.plot_compare_pos(time, output_sim, output_meas, 'images', 'aero');
            
%             testCase.assertEqual(output_sim, output_meas);
        end
    end
end

