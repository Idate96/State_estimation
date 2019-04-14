function [state_func_grad, output_func_grad] = find_jacobians(system, state_vars)
    % symbolic gradients
    state_func_grad = jacobian(system.state_func, state_vars);
    output_func_grad = jacobian(system.output_func, state_vars);
end