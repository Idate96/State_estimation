function [t,x] = runge_kutta_4(fn, t, x_0, u)
    x = x_0;
    num_iterations = 2;
    h = (t(2) - t(1)) / num_iterations;

    for j=1:num_iterations
        K1 = h * fn(t, x, u);
        K2 = h * fn(t+h/2, x+K1/2, u);
        K3 = h * fn(t+h/2, x+K2/2, u);
        K4 = h * fn(t+h, x+K3, u);
        x = x + (K1 + 2*K2 + 2*K3 + K4) / 6;
    end
end
