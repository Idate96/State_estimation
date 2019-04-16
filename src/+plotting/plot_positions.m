function plot_positions(data, save_path)
    fig1 = figure;
    set(gcf, 'Visible', 'off');
    subplot(3,1,1); plot(data.t, data.x);
    xlabel('time [sec]'); ylabel('x [m]', 'Interpreter','latex', 'FontSize', 15);
    subplot(3,1,2); plot(data.t, data.y);
    xlabel('time [sec]'); ylabel('y [m]', 'Interpreter','latex', 'FontSize', 15);
    subplot(3,1,3); plot(data.t, data.z);
    xlabel('time [sec]'); ylabel('z [m]', 'Interpreter','latex', 'FontSize', 15);
    saveas(fig1, join([save_path, '\position_time_series.png']));
end
