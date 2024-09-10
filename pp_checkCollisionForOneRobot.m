function collisions = pp_checkCollisionForOneRobot(trajectories,threshold,i)
    
    collisions = [];
    % WARNING: Don't edit this variable
    % Don't take it from the global variable
    % Because the number of robot on which you perform the collision check
    % might change!
    nRobots = length(trajectories);
    x_current = trajectories{i}.x_tot;
    y_current = trajectories{i}.y_tot;
    
    for j=1:nRobots
        if j~=i
            x2 = trajectories{j}.x_tot;
            y2 = trajectories{j}.y_tot;

            minLength = min(length(x_current),length(x2));
            for k = 1:minLength
                distance = norm([x_current(k),y_current(k)]-[x2(k),y2(k)]);
                
                if distance<threshold
                    collisions = [collisions; i j k distance trajectories{i}.t_tot(k)];
                end
            end
        end
    end
    
end

