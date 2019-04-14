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
            [system, state_vars, input_vars] = state_space.generate_state_space();
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
    end
end

