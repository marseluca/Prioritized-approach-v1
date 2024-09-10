function plots = pp_producePlots(trajectories)
    
    global nRobots;
    global pathColors;

    for j=1:nRobots
        figure(j+1)

        subplot(3,2,1)
        sgtitle("Robot "+j)

        plot(trajectories{j}.t_tot,trajectories{j}.x_tot,'LineWidth',1.2,'Color',pathColors(j,:));
        grid
        xlabel("t [s]")
        ylabel("$x(t)\:[m]$",'Interpreter','latex')


        subplot(3,2,2)
        plot(trajectories{j}.t_tot,trajectories{j}.y_tot,'LineWidth',1.2,'Color',pathColors(j,:));
        grid
        xlabel("t [s]")
        ylabel("$y(t)\:[m]$",'Interpreter','latex')


        subplot(3,2,3)
        plot(trajectories{j}.t_tot,trajectories{j}.xdot_tot,'LineWidth',1.2,'Color',pathColors(j,:));
        grid
        xlabel("t [s]")
        ylabel("$\dot{x}(t)\:[m/s]$",'Interpreter','latex')


        subplot(3,2,4)
        plot(trajectories{j}.t_tot,trajectories{j}.ydot_tot,'LineWidth',1.2,'Color',pathColors(j,:));
        grid
        xlabel("t [s]")
        ylabel("$\dot{y}(t)\:[m/s]$",'Interpreter','latex')


        subplot(3,2,5)
        plot(trajectories{j}.t_tot,trajectories{j}.xddot_tot,'LineWidth',1.2,'Color',pathColors(j,:));
        grid
        xlabel("t [s]")
        ylabel("$\ddot{x}(t)\:[m/s^2]$",'Interpreter','latex')


        subplot(3,2,6)
        plot(trajectories{j}.t_tot,trajectories{j}.yddot_tot,'LineWidth',1.2,'Color',pathColors(j,:));
        grid
        xlabel("t [s]")
        ylabel("$\ddot{y}(t)\:[m/s^2]$",'Interpreter','latex')
    end
    
end

