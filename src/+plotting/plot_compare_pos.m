function plot_compare_pos(time, simulated, measured, save_path, var_name)
    switch var_name
        
        case 'pos'
            fig1 = figure;
            set(gcf, 'Visible', 'off');
            subplot(3,1,1); plot(time, simulated(1, :), time, measured(1, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('x [m]', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,2); plot(time, simulated(2, :), time, measured(2, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('y [m]', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,3); plot(time, simulated(3, :), time, measured(3, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('z [m]', 'Interpreter','latex', 'FontSize', 15);
            saveas(fig1, join([save_path, '\comp_pos.png']));
            
         case 'vel'
            fig1 = figure;
            set(gcf, 'Visible', 'off');
            subplot(3,1,1); plot(time, simulated(4, :), time, measured(4, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('u [m/s]', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,2); plot(time, simulated(5, :), time, measured(5, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('v [m/s]', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,3); plot(time, simulated(6, :), time, measured(6, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('w [m/s]', 'Interpreter','latex', 'FontSize', 15);
            saveas(fig1, join([save_path, '\comp_vel.png']));
            
         case 'angle'
            fig1 = figure;
            set(gcf, 'Visible', 'off');
            subplot(3,1,1); plot(time, simulated(7, :), time, measured(7, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('$\phi$', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,2); plot(time, simulated(8, :), time, measured(8, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('$\theta$', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,3); plot(time, simulated(9, :), time, measured(9, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('$\psi$', 'Interpreter','latex', 'FontSize', 15);
            saveas(fig1, join([save_path, '\comp_angle.png']));
            
         case 'aero'
            fig1 = figure;
            set(gcf, 'Visible', 'off');
            subplot(3,1,1); plot(time, simulated(10, :), time, measured(10, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('V [m/s]', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,2); plot(time, simulated(11, :), time, measured(11, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('$\alpha$', 'Interpreter','latex', 'FontSize', 15);
            subplot(3,1,3); plot(time, simulated(12, :), time, measured(12, :));
            legend('simulated', 'measured');
            xlabel('time [sec]'); ylabel('$\beta$', 'Interpreter','latex', 'FontSize', 15);
            saveas(fig1, join([save_path, '\comp_aero.png']));
    end
    
end
